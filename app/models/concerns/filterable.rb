module Filterable
  extend ActiveSupport::Concern

  included do
    delegate :name, to: :state, prefix: true
    delegate :name, to: :city, prefix: true

    scope :random, -> { order("RANDOM()") }
    scope :unpaid, -> { where(paid: false) }
    scope :today, -> { where("created_at > ?", Date.today) }
    scope :week, -> { where("created_at > ?", Date.today.at_beginning_of_week) }
    scope :till_last_week, -> { where("created_at < ?", Date.today.at_beginning_of_week) }
    scope :older, ->(date) { where("created_at < ?", date) }
    scope :desc, -> { order("updated_at desc") }

    scope :active, -> { where(active: true) }
    scope :featured, -> { where(featured: true) }
    scope :state_id, ->(id) { where(state_id: id) }
    scope :city_id, -> (id) { where(city_id: id) }
    scope :fee, -> (fee) { where(fee: fee) }
    scope :post_type, -> (type) { where(post_type: type) }
    scope :category, -> (category) { where(category: category) }
    scope :subcategory, -> (subcategory) { where(subcategory: subcategory) }
    scope :duration, -> (type) { where(duration: type) }
    scope :rooms, -> (rooms) { where(rooms: rooms) }
    scope :baths, -> (num) { where("baths >= ?", num.to_i) }
    scope :space, -> (num) { where("space >= ?", num.to_i) }
    scope :min_price, -> (num) { where("price >= ?", num.to_i) }
    scope :max_price, -> (num) { where("price <= ?", num.to_i) }
    scope :sorted, ->(type) { order type }
    scope :tag_list, -> (tags) { tagged_with(tags, any: true) }

    scope(:geo_scope, lambda do |geo_scope|
      return if geo_scope[:within].blank? || geo_scope[:origin].blank?
      within(geo_scope[:within], origin: geo_scope[:origin])
    end)

    scope(:keyword, lambda do |keyword|
      query = "LOWER(title) LIKE ? OR LOWER(text) LIKE ?"
      keyword = "%#{keyword.mb_chars.downcase}%"
      where(query, keyword, keyword)
    end)

    scope(:street, lambda do |keyword|
      # todo rename street to title
      query = "LOWER(street) LIKE ? OR LOWER(text) LIKE ?"
      keyword = "%#{keyword.mb_chars.downcase}%"
      where(query, keyword, keyword)
    end)
  end

  module ClassMethods
    def filter(params)
      results = params[:sorted] ? active : active.order("featured desc, priority desc, updated_at desc")
      params.each do |key, value|
        results = results.public_send(key, value) unless value.blank?
      end
      results
    end
  end
end
