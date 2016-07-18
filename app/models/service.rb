class Service < ActiveRecord::Base
  acts_as_mappable
  include MyFriendlyId
  include Filterable
  include ViewHelpers

  validates :title, presence: true, length: { maximum: 44, minimum: 3 }
  validates :phone, presence: true
  validates :street, presence: true
  validates :category, presence: true
  validates :subcategory, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :user_id, presence: true

  belongs_to :state
  belongs_to :city
  belongs_to :user
  has_many :favorites, as: :favorable, dependent: :destroy

  has_one :stripe_subscription, dependent: :destroy
  has_one :entry, as: :enterable, dependent: :destroy

  scope :re_agencies, -> { where(subcategory: "Агентства Недвижимости") }
  scope :re_finances, -> { where(subcategory: "Финансирование") }
  scope :job_agencies, -> { where(subcategory: "Агентства по Трудоустройству") }

  delegate :active?, to: :stripe_subscription, allow_nil: true
  delegate :activated?, to: :stripe_subscription, allow_nil: true
  delegate :active_until, to: :stripe_subscription, allow_nil: true
  delegate :expired?, to: :stripe_subscription, allow_nil: true
  delegate :cancelled?, to: :stripe_subscription, allow_nil: true
  delegate :cancel, to: :stripe_subscription, allow_nil: true

  def self.active
    joins(:stripe_subscription).where(
      "stripe_subscriptions.active_until > ?", Date.current
    )
  end

  has_attached_file :logo, styles: { medium: "x120" }
  validates_attachment_content_type :logo, content_type: %r{\Aimage\/.*\Z}
  validates_attachment_file_name :logo, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with(
    AttachmentSizeValidator,
    attributes: :logo,
    less_than: 1.megabytes
  )

  def edit_link
    url_helpers.edit_dashboard_service_path(self)
  end

  def site_link
    site.match(/http/).present? ? site : "http://#{site}"
  end

  def trial?
    return false unless stripe_subscription
    stripe_subscription.status == "trial"
  end
end
