module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params)
      results = active
      filtering_params.each do |key, value|
        results = results.public_send(key, value) unless value.blank?
      end
      results
    end
  end
end
