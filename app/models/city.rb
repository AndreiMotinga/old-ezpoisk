class City < ActiveRecord::Base
  ALL = "all".freeze
  default_scope { order(:name) }

  belongs_to :state
  has_many :listings
end
