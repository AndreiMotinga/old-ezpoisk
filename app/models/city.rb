class City < ActiveRecord::Base
  default_scope { order(:name) }

  belongs_to :state
end
