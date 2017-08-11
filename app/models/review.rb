# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :listing
  validates_presence_of :text
  validates_presence_of :rating

  delegate :logo, to: :user
end
