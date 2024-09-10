# frozen_string_literal: true

module AfCore
  module CacheManager
    module_function

    CACHE_DURATION = 30.minutes

    # Normally we would want Rails.cache.fetch(cache_key(path, params), expires_in: expires_in, &)
    # but we must identify when we get a cache hit so we need to be explicit
    def cached(path, params, expires_in = CACHE_DURATION, klass_instance = nil, &)
      result = Rails.cache.fetch(cache_key(path, params), expires_in:)
      if result.present?
        key = "#{Rails.cache.options[:namespace]}:#{cache_key(path, params)}"
        klass_instance.cache_hit = Rails.cache.redis.ttl(key)
        result
      else
        Rails.cache.write(cache_key(path, params), yield, expires_in:)
        Rails.cache.fetch(cache_key(path, params), expires_in:)
      end
    end

    def delete(path, params)
      Rails.cache.delete(cache_key(path, params))
    end

    def cache_key(path, params)
      digest = Digest::MD5.hexdigest(params.sort.to_h.to_json)
      "cache-manager/#{path}/#{digest}"
    end
  end
end
