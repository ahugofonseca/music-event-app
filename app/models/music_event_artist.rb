# frozen_string_literal: true

# Used to associate Events and Artists many times
class MusicEventArtist < ApplicationRecord
  belongs_to :artist
  belongs_to :music_event
end
