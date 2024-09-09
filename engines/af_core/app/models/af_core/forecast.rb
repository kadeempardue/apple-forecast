module AfCore
  class Forecast < ActiveResourceBase
    attr_accessor :location, :minutely_timelines, :hourly_timelines, :daily_timelines

    def self.build(location:, timelines:)
      instance = self.new
      instance.build_location(location)
      instance.build_timelines(timelines)
      instance
    end

    def build_location(location)
      self.location = AfCore::Location.build(location || {})
    end

    def build_timelines(timelines)
      build_timelines_for(timelines, timeline_type: :minutely)
      build_timelines_for(timelines, timeline_type: :hourly)
      build_timelines_for(timelines, timeline_type: :daily)
    end

    def build_timelines_for(timelines, timeline_type:)
      public_send("#{timeline_type}_timelines=", AfCore::Timeline.build(timelines&.[]('timelines')&.[](timeline_type.to_s) || {}, timeline_type: timeline_type))
    end

    def now_timeline
      minutely_timelines.first
    end

    def current_time
      @current_time ||= DateTime.now
    end
  end
end