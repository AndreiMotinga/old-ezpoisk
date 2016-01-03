module Filterable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(active: true) }
    scope :state_id, ->(id) { where(state_id: id) }
    scope :city_ids, -> (ids) { where(city_id: ids) }
    scope :fee, -> (fee) { where(fee: fee) }
    scope :post_type, -> (type) { where(post_type: type) }
    scope :duration, -> (type) { where(duration: type) }
    scope :rooms, -> (num) { where("rooms >= ?", num.to_i) }
    scope :baths, -> (num) { where("baths >= ?", num.to_i) }
    scope :space, -> (num) { where("space >= ?", num.to_i) }
    scope :min_price, -> (num) { where("price >= ?", num.to_i) }
    scope :max_price, -> (num) { where("price <= ?", num.to_i) }
    scope :sort, ->(type) { order type }
  end

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
