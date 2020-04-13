# frozen_string_literal: true

FactoryBot.define do
  factory :music_event_artist do
    association :artist, factory: :artist
    association :music_event, factory: :music_event

    presentation_order { 1 }
  end
end
