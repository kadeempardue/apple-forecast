# frozen_string_literal: true

module AfCore
  class Timeline
    def initialize(data, timeline_type)
      load(data, timeline_type)
    end

    def daily?
      timeline_type == :daily
    end

    def hourly?
      timeline_type == :hourly
    end

    def minutely?
      timeline_type == :minutely
    end

    def self.build(data, timeline_type:)
      data.map { |data_set| new(data_set, timeline_type) }
    end

    private

    def load(data, timeline_type)
      define_attr_accessor(:timeline_type, timeline_type)

      data.each do |key, value|
        define_attr_accessor(key.underscore, value)
        key == 'values' ? value.each { |k, v| define_attr_accessor(k.underscore, v) } : next
      end
    end

    def define_attr_accessor(key, value)
      singleton_class.instance_eval { attr_accessor key }
      public_send("#{key}=", value)
    end
  end
end
