class Entry < ActiveRecord::Base
  belongs_to :enterable, polymorphic: true
  belongs_to :user

  validates :user_id, presence: true

  scope :today, -> { where("updated_at > ?", Date.today) }
  scope :week, -> { where("updated_at > ?", Date.today.at_beginning_of_week) }
end
