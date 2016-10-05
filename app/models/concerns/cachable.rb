# cachable methods for listings
module Cachable
  extend ActiveSupport::Concern

  module ClassMethods
    def cached_find(id)
      Rails.cache.fetch([name, id]) { find_by_id(id) }
    end

    def cached_active_count
      Rails.cache.fetch([name, :cached_active_count]) { active.count }
    end

    def cached_active_week_count
      Rails.cache.fetch([name, :cached_active_week_count], expires_in: 1.week) do
        active.week.count
      end
    end

    def cached_active_today_count
      Rails.cache.fetch([name, :cached_active_today_count], expires_in: 1.day) do
        active.today.count
      end
    end
  end

  included do
    after_commit :flush_cache
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete([self.class.name, :cached_active_count])
    Rails.cache.delete([self.class.name, :cached_active_week_count])
    Rails.cache.delete([self.class.name, :cached_active_today_count])

    Rails.cache.delete([self.class.name, id, :cached_city])
    Rails.cache.delete([self.class.name, id, :cached_state])
    Rails.cache.delete([self.class.name, id, :cached_user])
    Rails.cache.delete([self.class.name, id, :cached_logo])
    Rails.cache.delete([self.class.name, id, :cached_pictures_count])
  end

  def cached_city
    Rails.cache.fetch([self.class.name, id, :cached_city]) { city }
  end

  def cached_state
    Rails.cache.fetch([self.class.name, id, :cached_state]) { state }
  end

  def cached_logo
    Rails.cache.fetch([self.class.name, id, :cached_logo]) do
      pictures.find_by_logo(true)
    end
  end

  def cached_user
    Rails.cache.fetch([self.class.name, id, :cached_user]) { user }
  end

  def cached_pictures_count
    Rails.cache.fetch([self.class.name, id, :cached_pictures_count]) do
      pictures.count
    end
  end
end
