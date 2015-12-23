class ReAgency < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :phone, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :user_id, presence: true

  belongs_to :state
  belongs_to :city
  belongs_to :user

  has_attached_file :logo,
                    styles: { thumb: "200x100>" },
                    default_url: "missing.png"
  validates_attachment_content_type :logo,
                                    content_type: /\Aimage\/.*\Z/

  def show_description
    description.blank? ? I18n.t(:no_description) : description
  end
end
