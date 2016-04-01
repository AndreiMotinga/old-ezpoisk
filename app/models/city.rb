class City < ActiveRecord::Base
  default_scope { order(:name) }

  belongs_to :state
  # todo test
  has_many :partner_cities
end
