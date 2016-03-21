class Page < ActiveRecord::Base
  has_many :partner_pages
  has_many :partners, through: :partner_pages
end
