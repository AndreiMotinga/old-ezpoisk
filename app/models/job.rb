class Job < ActiveRecord::Base
  acts_as_mappable
  include MyFriendlyId
  include Filterable
  include ViewHelpers

  validates :title, length: { maximum: 90 }
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :user_id, presence: true

  belongs_to :state
  belongs_to :city
  belongs_to :user

  has_many :favorites, as: :favorable, dependent: :destroy
  has_one :entry, as: :enterable, dependent: :destroy

  has_attached_file(:logo, styles: { medium: ["300x170>", :jpg],
                                     large: ["755x425#", :jpg] },
                    default_url: "https://s3.amazonaws.com/ezpoisk/missing.png")
  validates_attachment_content_type :logo, content_type: %r{\Aimage\/.*\Z}
  validates_with(
    AttachmentSizeValidator,
    attributes: :logo,
    less_than: 1.megabytes
  )

  def edit_link
    url_helpers.edit_dashboard_job_path(self)
  end
end
