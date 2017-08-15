# frozen_string_literal: true

module Impressionable
  extend ActiveSupport::Concern

  module ClassMethods
  end

  included do
    has_many :impressions, as: :impressionable, dependent: :destroy

    def ctr
      show = impressions.show.count
      visits = impressions.visit.count
      return 0 if [show, visits].any?(&:zero?)
      ((visits.to_f / show) * 100).round
    end

  end
end
