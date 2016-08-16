class Post < ActiveRecord::Base
  include MyFriendlyId
  include Filterable
  include ViewHelpers
  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :summary, presence: true, length: {  maximum: 400, minimum: 80 }
  validates :text, presence: true
  CATEGORIES = %w(world us top tech money science autonews entertainment travel
                 user).freeze

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :favorites, as: :favorable, dependent: :destroy
  delegate :avatar, to: :user
  has_one :entry, as: :enterable, dependent: :destroy

  has_attached_file :image, styles: { medium: "810" }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  attr_reader :image_remote_url
  def image_remote_url=(url_value)
    if url_value.present?
      self.image = URI.parse(url_value)
      @image_remote_url = url_value
    end
  end

  scope :desc, -> { order("posts.updated_at desc") }
  scope :visible, -> { where(visible: true) }
  scope :invisible, -> { where(visible: false) }
  scope :today, -> { where("created_at > ?", Time.zone.yesterday) }

  def self.this_week
    where("created_at > ?", Date.today.at_beginning_of_week).count
  end

  def self.by_keyword(keyword)
    return all if keyword.blank?
    keys = convert_keyword(keyword)
    query = "LOWER(title) ILIKE ANY (array[?]) OR LOWER(text) ILIKE ANY (array[?])"
    where(query, keys, keys)
  end

  def self.category(category)
    return all if category.blank?
    where(category: category)
  end

  def self.convert_keyword(keyword)
    keyword.gsub(/[^0-9a-zа-я ]/i, "")
           .split(" ")
           .map { |key| "%#{key.mb_chars.downcase}%" }
  end

  def logo_url(style = :medium)
    image.url(style)
  end

  def edit_link
    url_helpers.edit_dashboard_post_path(self)
  end

  def show_url
    url_helpers.post_url(self)
  end

  def active?
    true
  end
end
