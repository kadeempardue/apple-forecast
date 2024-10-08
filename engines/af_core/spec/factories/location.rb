# frozen_string_literal: true

FactoryBot.define do
  factory :location, class: 'AfCore::Location' do
    city { 'Atlanta' }
    state  { 'Georgia' }
    country { 'United States' }
  end
end
