class RePrivate < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  acts_as_mappable
  include Filterable
  include ViewHelpers

  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0 }
  validates :rooms, presence: true
  validates :phone, presence: true
  validates :post_type, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :street, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :pictures, as: :imageable, dependent: :destroy

  def title
    street
  end

  def link
    "ezrealty/private/#{id}"
  end

  def block
    "Недвижимость"
  end

  def edit_link
    edit_dashboard_re_private_path(self)
  end

  def delete_link
    dashboard_re_private_path(self)
  end

  def logo_url(style = :medium)
    logo.present? ? logo.image.url(style) : "missing.png"
  end

  def email
    user.email
  end
end
