# frozen_string_literal: true

# Responsable by businnes rules about MusicEvent
class MusicEvent < ApplicationRecord
  # Associations
  has_many :music_event_artists
  has_many :artists, through: :music_event_artists

  # Validations
  validates_presence_of :local, :scheduled_date_time, :event_type, :genres

  # Enums
  enum event_type: %i[concert festival]

  # Scopes
  scope :all_in_time_zone, lambda { |offset = '+0000'|
    select("
      music_events.*,
      scheduled_date_time AT TIME ZONE
        '#{MusicEvent.find_time_zone_by(offset).formatted_offset}'
      AS scheduled_date_time_timezone_converted
    ")
  }

  # Methods
  def self.find_time_zone_by(offset)
    offset = offset.nil? ? '+0000' : offset

    ActiveSupport::TimeZone.all.find do |timezone|
      timezone.formatted_offset(false) == offset
    end
  end
end
