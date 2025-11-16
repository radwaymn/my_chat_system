redis_url = ENV["REDIS_URL"]||  "redis://redis:6379/0"

REDIS  = Redis.new(url: redis_url)
