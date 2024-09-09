module AfCore
  class Timeline
    def initialize(data, timeline_type)
      singleton_class.instance_eval { attr_accessor timeline_type }
      public_send("#{timeline_type}=", timeline_type)

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

    def self.build_from_data(data, timeline_type:)
      data.map do |data_set|
        new(data_set, timeline_type)
      end
    end
  end
end