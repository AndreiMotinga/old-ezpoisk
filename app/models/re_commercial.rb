class ReCommercial < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  acts_as_mappable
  include Filterable
  include ViewHelpers

  validates :post_type, presence: true
  validates :category, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :street, presence: true
  validates :user_id, presence: true
  validates :phone, presence: true

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :pictures, as: :imageable, dependent: :destroy

  def title
    street
  end

  def logo_url(style = :medium)
    logo.present? ? logo.image.url(style) : "https://s3.amazonaws.com/ezpoisk/missing.png"
  end

  # todo remove?
  def email
    user.email
  end
end
