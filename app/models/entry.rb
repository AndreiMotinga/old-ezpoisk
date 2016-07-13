class Entry < ActiveRecord::Base
  belongs_to :enterable, polymorphic: true

  scope :today, -> { where("created_at > ?", Time.zone.yesterday) }
end
