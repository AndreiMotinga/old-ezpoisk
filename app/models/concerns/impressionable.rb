# frozen_string_literal: true

module Impressionable
  extend ActiveSupport::Concern

  module ClassMethods
  end

  included do
    has_many :impressions, as: :impressionable, dependent: :destroy
  end
end
