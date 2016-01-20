$redis ||= Redis.new(:url => (ENV["REDIS_PROVIDER"] || 'redis://127.0.0.1:6379'))
