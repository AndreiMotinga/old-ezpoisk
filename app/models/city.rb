class City < ActiveRecord::Base
  default_scope { order(:name) }

  belongs_to :state
  has_many :partner_cities
end
