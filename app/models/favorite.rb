class Favorite < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :post_id, presence: true
  validates :post_type, presence: true
end
