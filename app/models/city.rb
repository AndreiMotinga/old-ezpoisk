class City < ActiveRecord::Base
  ALL = "all".freeze
  default_scope { order(:name) }

  belongs_to :state
end
