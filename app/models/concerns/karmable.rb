# frozen_string_literal: true

module Karmable
  extend ActiveSupport::Concern

  module ClassMethods
  end

  included do
    has_many :karmas, as: :karmable, dependent: :destroy
  end
end
