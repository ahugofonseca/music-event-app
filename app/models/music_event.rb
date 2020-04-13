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
  scope :filtered_by_genre, lambda { |genre|
    where(':genre_item = ANY(genres)', genre_item: genre)
  }

  scope :all_in_time_zone, lambda { |offset = '+0000'|
    select("
      music_events.*,
      scheduled_date_time AT TIME ZONE
        '#{MusicEvent.find_time_zone_by(offset).formatted_offset}'
      AS scheduled_date_time_timezone_converted
    ")
  }

  # Methods
  def self.filtered_by_genres(genres_list)
    return all if genres_list.nil?

    queries = genres_list.map do |genre|
      { method: :filtered_by_genre,
        argument: genre }
    end

    queries.inject(self) do |klass, query|
      klass.send(query[:method], query[:argument])
    end
  end

  def self.find_time_zone_by(offset)
    offset = offset.nil? ? '+0000' : offset

    ActiveSupport::TimeZone.all.find do |timezone|
      timezone.formatted_offset(false) == offset
    end
  end
end
