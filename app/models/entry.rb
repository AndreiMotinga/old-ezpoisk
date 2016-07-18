class Entry < ActiveRecord::Base
  belongs_to :enterable, polymorphic: true

  scope :today, -> { where("created_at > ?", Date.today) }
  scope :week, -> { where("created_at > ?", Date.today.at_beginning_of_week) }
end
