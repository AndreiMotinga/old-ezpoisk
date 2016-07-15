class Entry < ActiveRecord::Base
  belongs_to :enterable, polymorphic: true

  scope :today, -> { where("created_at > ?", Time.zone.today) }
  scope :week, -> { where("created_at > ?", Date.current.at_beginning_of_week) }
end
