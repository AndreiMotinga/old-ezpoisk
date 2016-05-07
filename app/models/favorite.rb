class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :favorable, polymorphic: true

  validates :user, presence: true
  validates :favorable_id, presence: true
  validates :favorable_type, presence: true
end
