class Entry < ActiveRecord::Base
  include Filterable
  belongs_to :enterable, polymorphic: true
  belongs_to :user

  validates :user_id, presence: true
end
