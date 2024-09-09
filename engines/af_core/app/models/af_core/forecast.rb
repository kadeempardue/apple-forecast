module AfCore
  class Forecast < ActiveResourceBase

    def self.build_from_timelines(timelines)
      instance = self.new
      instance.build_timelines(timelines)
      instance
    end

    def build_timelines(timelines)
      build_timelines_for(timelines, timeline_type: :minutely)
      build_timelines_for(timelines, timeline_type: :hourly)
      build_timelines_for(timelines, timeline_type: :daily)
    end

    def build_timelines_for(timelines, timeline_type:)
      singleton_class.instance_eval { attr_accessor "#{timeline_type}_timelines" }
      public_send("#{timeline_type}_timelines=", AfCore::Timeline.build_from_data(timelines&.[]('timelines')&.[](timeline_type.to_s) || {}, timeline_type: timeline_type))
    end
  end
end