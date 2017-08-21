# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(params)
      results = params[:sorted] ? active : active.default
      params.each do |key, value|
        results = results.public_send(key, value) unless value.blank?
      end
      results
    end
  end

  included do
    include Searchable
    scope :term, ->(term) { search(term) }
    scope :default , -> { order("featured desc, priority desc,
                                #{table_name}.updated_at desc") }
    scope :today, -> { where("#{table_name}.created_at > ?", Date.today) }
    scope :week, -> { where("#{table_name}.created_at > ?",
                            Date.today.at_beginning_of_week) }
    scope :featured, -> { where(featured: true) }
    scope :desc, -> { order("#{table_name}.created_at desc") }
    scope :older, -> (time) { where("#{table_name}.created_at < ?", time) }
    scope :random, -> { order("RANDOM()") }
    scope :unpaid, -> { where(paid: false) }
    scope :active, -> { where(active: true) }
    scope :state_id, ->(id) { where(state_id: id) }
    scope :city_id, ->(id) { where(city_id: id) }
    scope :state, ->(slug) { where(state_id: State.find_by_slug(slug).try(:id)) }
    scope :city, ->(slug) { where(city_id: City.find_by_slug(slug).try(:id)) }
    scope :category, ->(category) { where(category: category) }
    scope :subcategory, ->(subcategory) { where(subcategory: subcategory) }
    scope :duration, ->(type) { where(duration: type) }
    scope :rooms, ->(rooms) { where(rooms: rooms) }
    scope :baths, ->(num) { where("baths >= ?", num.to_i) }
    scope :space, ->(num) { where("space >= ?", num.to_i) }
    scope :min_price, ->(num) { where("price >= ?", num.to_i) }
    scope :max_price, ->(num) { where("price <= ?", num.to_i) }
    scope :sorted, ->(type) { order type }
    scope :tag_list, ->(tags) { tagged_with(tags, any: true) }
    scope :kind, ->(kind) { where(kind: kind) }

    scope(:geo_scope, lambda do |geo_scope|
      return if geo_scope[:within].blank? || geo_scope[:origin].blank?
      within(geo_scope[:within], origin: geo_scope[:origin])
    end)
  end
end
