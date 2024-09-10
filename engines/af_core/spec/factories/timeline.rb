# frozen_string_literal: true

FactoryBot.define do
  factory :timeline, class: 'AfCore::Timeline' do
    transient do
      data do
        JSON.parse(File.read("#{Rails.root}/engines/af_core/spec/fixtures/timeline1.json"))['timelines']['daily'][0]
      end
      timeline_type { :daily }
    end

    initialize_with { AfCore::Timeline.new(data, timeline_type) }
  end
end
