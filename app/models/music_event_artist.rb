# frozen_string_literal: true

# Used to associate Events and Artists many times
class MusicEventArtist < ApplicationRecord
  # Associations
  belongs_to :artist
  belongs_to :music_event

  # Validations
  validates_presence_of :presentation_order
  validates_uniqueness_of :artist_id, scope: :music_event_id

  # Alias and Delegators
  delegate :name, to: :artist, prefix: true
end
