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
      singleton_class.instance_eval { attr_accessor :timeline_type }
      self.timeline_type = timeline_type

      data.each do |key, value|
        singleton_class.instance_eval { attr_accessor key.underscore }
        public_send("#{key.underscore}=", value)
        if key == 'values'
          value.each do |k, v|
            singleton_class.instance_eval { attr_accessor k.underscore }
            public_send("#{k.underscore}=", v)
          end
        end
      end
    end
  end
end