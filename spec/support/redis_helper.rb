# frozen_string_literal: true

module RSpec
  module RedisHelper
    def self.included(rspec)
      rspec.around(:each, redis: true) do |example|
        with_clean_redis do
          example.run
        end
      end
    end

    CONFIG = { url: ENV['REDIS_URL'] || 'redis://127.0.0.1:6379/1' }.freeze

    def redis
      @redis ||= ::Redis.connect(CONFIG)
    end

    def with_clean_redis
      redis.flushall
      begin
        yield
      ensure
        redis.flushall
      end
    end
  end
end
