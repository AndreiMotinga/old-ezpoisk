class State < ActiveRecord::Base
  default_scope { order(:name) }

  has_many :cities
end
