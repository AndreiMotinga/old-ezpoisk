class ReCommercial < ActiveRecord::Base
  acts_as_mappable
  include Filterable
  include ViewHelpers

  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0 }
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
end
