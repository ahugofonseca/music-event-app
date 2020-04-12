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
end
