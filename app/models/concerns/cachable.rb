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
      Rails.cache.fetch([name, :cached_active_week_count]) { active.week.count }
    end

    def cached_active_today_count
      Rails.cache.fetch([name, :cached_active_today_count]) { active.today.count }
    end
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete([self.class.name, :cached_active_count])
    Rails.cache.delete([self.class.name, :cached_active_week_count])
    Rails.cache.delete([self.class.name, :cached_active_today_count])
    Rails.cache.delete([self.class.name, id, :cached_city_name])
    Rails.cache.delete([self.class.name, id, :similar])
  end

  def cached_city_name
    Rails.cache.fetch([self.class.name, id, :cached_city_name]) { city.name }
  end
end
