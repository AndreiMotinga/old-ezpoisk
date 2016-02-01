class JobAgency < ActiveRecord::Base
  acts_as_mappable
  include Filterable
  include ViewHelpers

  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :phone, presence: true
  validates :street, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :user_id, presence: true

  belongs_to :state
  belongs_to :city
  belongs_to :user

  has_attached_file :logo,
                    styles: { medium: "300x150>" },
                    :s3_protocol => :https,
                    default_url: "missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :logo, matches: [/png\Z/, /jpe?g\Z/]
end
