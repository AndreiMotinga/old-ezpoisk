# frozen_string_literal: true

class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :state
  belongs_to :city

  has_many :partners, dependent: :destroy
  has_many :impressions, through: :partners

  validates_presence_of :user
  validates_presence_of :state

  def ctr
    show = impressions.show.count
    visits = impressions.visit.count
    return 0 if [show, visits].any?(&:zero?)
    ((visits.to_f / show) * 100).round
  end
end
