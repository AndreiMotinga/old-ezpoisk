class Sale < ActiveRecord::Base
  acts_as_mappable
  include MyFriendlyId
  include Filterable
  include ViewHelpers

  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :category, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :user_id, presence: true

  belongs_to :state
  belongs_to :city
  belongs_to :user
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :favorites, as: :favorable, dependent: :destroy
  has_one :entry, as: :enterable, dependent: :destroy

  def edit_link
    Rails.application.routes.url_helpers.edit_dashboard_sale_path(self)
  end
end
