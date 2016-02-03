class Sale < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  acts_as_mappable
  include Filterable
  include ViewHelpers

  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :phone, presence: true
  validates :category, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :user_id, presence: true

  belongs_to :state
  belongs_to :city
  belongs_to :user
  has_many :pictures, as: :imageable, dependent: :destroy

  def link
    "/sales/#{id}"
  end

  def block
    "Продается"
  end

  def edit_link
    edit_dashboard_sale_path(self)
  end

  def delete_link
    dashboard_sale_path(self)
  end

  def logo_url(style = :medium)
    logo.present? ? logo.image.url(style) : "missing.png"
  end
end
