class State < ActiveRecord::Base
  default_scope { order(:name) }

  has_many :cities
  has_many :listings
end
