class PartnerPage < ActiveRecord::Base
  belongs_to :page
  belongs_to :partner
end
