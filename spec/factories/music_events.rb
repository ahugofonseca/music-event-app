# frozen_string_literal: true

FactoryBot.define do
  factory :music_event do
    local               { 'Street A, 245, Rio de Janeiro, RJ, Brazil' }
    scheduled_date_time { DateTime.now + 30.days }
    event_type          { :festival }
    genres              { %w[rock blues] }

    trait :with_time_zone_converted do
      after(:create) do |_music_event|
        MusicEvent.all_in_time_zone('-0300')
      end
    end
  end
end
