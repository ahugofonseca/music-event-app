# frozen_string_literal: true

FactoryBot.define do
  factory :music_event do
    local               { 'Street A, 245, Rio de Janeiro, RJ, Brazil' }
    scheduled_date_time { DateTime.now + 30.days }
    event_type          { :festival }
    genres              { %w[rock blues] }
  end
end
