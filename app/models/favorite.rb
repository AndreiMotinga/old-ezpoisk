# User selected listing. User can save them or hide.
class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :favorable, polymorphic: true

  validates :user, presence: true
  validates :favorable_id, presence: true
  validates :favorable_type, presence: true

  scope :saved, -> { where(saved: true) }
end
