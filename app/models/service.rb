class Service < ActiveRecord::Base
  acts_as_mappable
  include Filterable
  include ViewHelpers
  include Tokenable

  validates :title, presence: true, length: { maximum: 44, minimum: 3 }
  validates :category, presence: true
  validates :subcategory, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :street, presence: true
  validates :phone, presence: true

  belongs_to :state
  belongs_to :city
  belongs_to :user, optional: true
  has_many :favorites, as: :favorable, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :reviews

  has_one :stripe_subscription, dependent: :destroy
  has_one :entry, as: :enterable, dependent: :destroy

  has_attached_file :logo, styles: { medium: "x120",
                                     avatar: "100x100#", right: "300x250#" }
  validates_attachment_content_type :logo, content_type: %r{\Aimage\/.*\Z}
  validates_attachment_file_name :logo, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with(
    AttachmentSizeValidator,
    attributes: :logo,
    less_than: 1.megabytes
  )

  has_attached_file(:cover, styles: { large: "780x390#" },
    default_url: "https://s3.amazonaws.com/ezpoisk/pictures/service-default-cover.jpg")
  validates_attachment_content_type :cover, content_type: %r{\Aimage\/.*\Z}

  def edit_link
    url_helpers.edit_dashboard_service_path(self)
  end

  def edit_url_with_token
    url_helpers.edit_dashboard_service_url(self, token: token)
  end

  def show_url
    url_helpers.service_url(self)
  end

  def rating
    reviews.average(:rating).try(:round)
  end

  def side_items
    Service.category(category)
           .subcategory(subcategory)
           .where.not(id: id)
           .order("featured desc, priority desc, updated_at desc")
           .limit(3)
  end

  def active?
    true
  end
end
