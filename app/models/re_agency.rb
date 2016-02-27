class ReAgency < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  acts_as_mappable
  include Filterable
  include ViewHelpers

  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :phone, presence: true
  validates :state_id, presence: true
  validates :street, presence: true
  validates :city_id, presence: true
  validates :user_id, presence: true

  belongs_to :state
  belongs_to :city
  belongs_to :user

  has_attached_file(:logo,
                    styles: { medium: ["300x170>", :jpg] },
                    default_url: "missing.png")
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :logo, matches: [/png\Z/, /jpe?g\Z/]
  validates_with AttachmentSizeValidator, attributes: :logo, less_than: 5.megabytes

  def link
    "/ezrealty/agencies/#{id}"
  end

  def edit_link
    edit_dashboard_re_agency_path(self)
  end

  def delete_link
    dashboard_re_agency_path(self)
  end

  def block
    "Недвижимости"
  end

  def logo_url(style = :medium)
    logo.url(style)
  end
end
