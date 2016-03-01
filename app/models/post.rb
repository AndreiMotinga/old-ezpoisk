class Post < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates_uniqueness_of :title
  validates :category, presence: true

  belongs_to :user

  attr_reader :image_remote_url
  has_attached_file(:image,
                    styles: { small: ["158x99#"], medium: ["585x329#", :jpg] },
                    default_url: "missing.png")
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  def image_remote_url=(url_value)
    if url_value.present?
      self.image = URI.parse(url_value)
      @image_remote_url = url_value
    end
  end

  scope :desc, -> { order("created_at desc") }
  scope :for_homepage, -> { where(show_on_homepage: true) }
  scope :main, -> { where(main: true).last }
  scope :main_posts, -> { where(main: true).order("updated_at desc") }
  scope :with_logo, -> { where.not(image_file_name: nil) }

  def self.by_category(category)
    where("LOWER(category) LIKE ?", "%#{category.mb_chars.downcase}%")
  end

  def self.by_subcategory(subcategory)
    where("LOWER(subcategory) LIKE ?", "%#{subcategory.mb_chars.downcase}%")
  end

  def logo_url(style = :medium)
    image.url(style)
  end
end
