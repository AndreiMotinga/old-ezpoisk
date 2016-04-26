class ReCommercial < ActiveRecord::Base
  acts_as_mappable
  include Filterable
  include ViewHelpers

  validates :post_type, presence: true
  validates :price, presence: true
  validates :category, presence: true
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

  def paid?
    false
  end
end
