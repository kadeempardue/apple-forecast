# frozen_string_literal: true

module AfFrontend
  module ApplicationHelper
    def friendly_location(location)
      address = []
      address.push([location.city, location.state].compact)
      address[0].insert(1, ', ') if location.city && location.state
      address[0] = address[0].join.presence
      address.push(location.country)
      address.compact.join(' ')
    end

    def friendly_day(date)
      date.strftime('%b %d')
    end

    def friendly_time(time)
      friendly_time = time.strftime('%H:%M %p ')
      timezone = Time.parse(friendly_time).strftime('%Z')
      [friendly_time, timezone].join
    end

    def friendly_weather_icon(timeline)
      dir = AfFrontend::DIRECTORY_TOMMOROW_ICONS
      weather_code = (timeline.daily? ? timeline.weather_code_min : timeline.weather_code).to_s.ljust(5, '0')
      file_name = get_files_by_pattern(dir, weather_code)
      file_name = file_name.split('images/af_frontend/').last
      image_tag "af_frontend/#{file_name}", style: 'margin-top: -1.5em'
    end

    # TODO: Move to FileManagerService or similar
    def get_files_by_pattern(dir, pattern)
      Dir.glob(File.join(dir, '/*.png')).select do |f|
        f.split('/')[-1][/^#{pattern}.*@2x\.png$/]
      end.first
    end
  end
end
