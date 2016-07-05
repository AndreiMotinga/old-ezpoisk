class Entry < ActiveRecord::Base
  belongs_to :enterable, polymorphic: true
end
