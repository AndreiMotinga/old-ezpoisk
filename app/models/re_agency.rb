class ReAgency < ActiveRecord::Base
  acts_as_mappable
  include Filterable
  include ViewHelpers

  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :phone, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :user_id, presence: true

  belongs_to :state
  belongs_to :city
  belongs_to :user
  has_many :pictures, as: :imageable, dependent: :destroy

  has_attached_file :logo,
                    styles: { medium: "300x150>" },
                    default_url: "missing.png"
  validates_attachment_content_type :logo,
                                    content_type: /\Aimage\/.*\Z/

end
