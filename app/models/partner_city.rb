class PartnerCity < ActiveRecord::Base
  # todo tests
  belongs_to :parner
  belongs_to :city
end
