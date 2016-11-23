class Post < ActiveRecord::Base
  acts_as_taggable
  include MyFriendlyId
  include Filterable
  include ListingHelpers
  include Commentable

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
  delegate :logo, to: :user

  has_attached_file :image, styles: { medium: "x330>", thumb: "x160#" }
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

  def logo_url(style = :medium)
    image.url(style)
  end

  def edit_link
    Rails.application.routes.url_helpers.edit_dashboard_post_path(self)
  end

  def show_url
    Rails.application.routes.url_helpers.post_url(self)
  end

  def update_cached_tags
    update_column(:cached_tags, tags.pluck(:name).join(", "))
  end

  def active
    true
  end
end
