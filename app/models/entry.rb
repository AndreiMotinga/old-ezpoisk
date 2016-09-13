class Entry < ActiveRecord::Base
  include Filterable
  belongs_to :enterable, polymorphic: true
  belongs_to :user

  validates :user_id, presence: true

  scope :desc, -> { order("created_at desc") }
  scope :news, -> { where(enterable_type: %w(Answer Post)) }
  scope :listings, -> { where(enterable_type: %w(RePrivate Sale Service Job)) }
end
