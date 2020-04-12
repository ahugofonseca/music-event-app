# frozen_string_literal: true

# Responsable by businnes rules about Artist
class Artist < ApplicationRecord
  # Associations
  has_many :music_event_artists
  has_many :music_events, through: :music_event_artists

  # Validations
  validates :name, presence: true, uniqueness: true
end
