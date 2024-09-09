module AfCore
  module CacheManager
    extend self

    # Normally we would want Rails.cache.fetch(cache_key(path, params), expires_in: expires_in, &)
    # but we must identify when we get a cache hit so we need to be verbose
    def cached(path, params, expires_in = 30.minutes, klass_instance = nil, &)
      result = Rails.cache.fetch(cache_key(path, params), expires_in: expires_in)
      if result.present?
        klass_instance.cache_hit = Rails.cache.redis.ttl("#{Rails.cache.options[:namespace]}:#{cache_key(path, params)}")
        return result
      end
      Rails.cache.write(cache_key(path, params), yield, expires_in: expires_in)
      Rails.cache.fetch(cache_key(path, params), expires_in: expires_in)
    end

    def delete(path, params)
      Rails.cache.delete(cache_key(path, params))
    end

    protected

    def cache_key(path, params)
      digest = Digest::MD5.hexdigest(params.sort.to_h.to_json)
      "cache-manager/#{path}/#{digest}"
    end
  end
end
