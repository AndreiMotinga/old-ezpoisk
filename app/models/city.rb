# frozen_string_literal: true

class City < ActiveRecord::Base
  default_scope { order(:name) }

  belongs_to :state
  has_many :listings
end
