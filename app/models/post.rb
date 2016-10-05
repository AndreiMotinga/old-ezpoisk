class Post < ActiveRecord::Base
  acts_as_taggable
  include MyFriendlyId
  include Filterable
  include ListingHelpers
  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :summary, presence: true, length: {  maximum: 400, minimum: 30 }
  validates :text, presence: true
  CATEGORIES = %w(
    world usa top tech money science autonews entertainment travel
  ).freeze

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :favorites, as: :favorable, dependent: :destroy
  delegate :avatar, to: :user
  has_one :entry, as: :enterable, dependent: :destroy

  has_attached_file :image, styles: { medium: "810", thumb: "x160#" }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  attr_reader :image_remote_url
  def image_remote_url=(url_value)
    if url_value.present?
      self.image = URI.parse(url_value)
      @image_remote_url = url_value
    end
  end

  scope :visible, -> { where(visible: true) }
  scope :invisible, -> { where(visible: false) }

  def self.convert_keyword(keyword)
    keyword.gsub(/[^0-9a-zа-я ]/i, "")
           .split(" ")
           .map { |key| "%#{key.mb_chars.downcase}%" }
  end

  def self.category(category)
    return all unless category.present?
    where(category: category)
  end

  def logo_url(style = :medium)
    image.url(style)
  end

  def edit_link
    Rails.application.routes.url_helpers.edit_dashboard_post_path(self)
  end

  def show_url
    Rails.application.routes.url_helpers.post_url(self)
  end

  def active
    true
  end
end
