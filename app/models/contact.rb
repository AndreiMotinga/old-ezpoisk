# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :state
  belongs_to :city
end
