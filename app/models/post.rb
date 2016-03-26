class Post < ActiveRecord::Base
  # conflict RailsAdmin and Impressionist
  include Impressionist::IsImpressionable
  is_impressionable :counter_cache => true
  extend FriendlyId
  friendly_id :title, use: [:slugged]
  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates_uniqueness_of :title
  validates :category, presence: true

  belongs_to :user

  attr_reader :image_remote_url
  has_attached_file(:image,
                    styles: { small: ["158x99#"], medium: ["585x329#", :jpg], large: ["755x425#", :jpg] },
                    default_url: "https://s3.amazonaws.com/ezpoisk/missing.png")
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  def image_remote_url=(url_value)
    if url_value.present?
      self.image = URI.parse(url_value)
      @image_remote_url = url_value
    end
  end

  scope :desc, -> { order("created_at desc") }
  scope :by_views, -> { order("impressions_count desc") }
  scope :for_homepage, -> { where(show_on_homepage: true) }
  scope :interesting, -> { where(interesting: true) }
  scope :main, -> { where(main: true).last }
  scope :main_posts, -> { where(main: true).order("updated_at desc") }
  scope :with_logo, -> { where.not(image_file_name: nil) }

  def self.by_category(category)
    return all unless category.present?
    where(category: category)
  end
  scope :older, -> (id) { where("id < ?", id) }

  def logo_url(style = :medium)
    image.url(style)
  end

  def side_posts
    Post.older(id).by_category(category).with_logo.by_views.limit(4)
  end

  def normalize_friendly_id(text)
    text.to_slug.normalize(transliterations: :russian).to_s
  end

  def should_generate_new_friendly_id?
    title_changed?
  end
end
