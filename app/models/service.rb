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
  has_one :stripe_subscription, as: :payable, dependent: :destroy

  scope :active, -> { where("active_until > ?", Date.today) }
  scope :re_agencies, -> { where(subcategory: "Агентства Недвижимости") }
  scope :re_finances, -> { where(subcategory: "Финансирование") }
  scope :job_agencies, -> { where(subcategory: "Агентства по Трудоустройству") }


  has_attached_file(:logo,
                    styles: { medium: ["300x170>", :jpg] },
                    default_url: "https://s3.amazonaws.com/ezpoisk/missing.png")
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :logo, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with AttachmentSizeValidator, attributes: :logo, less_than: 5.megabytes

  def active?
    active_until.try(:future?)
  end

  def extend(period)
    self.active_until = active_until? ? active_until : Date.today
    self.active_until += period
    self.save
  end
end
