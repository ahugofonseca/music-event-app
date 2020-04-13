# frozen_string_literal: true

# Music Event Artist Serializer Class
class MusicEventArtistSerializer < ActiveModel::Serializer
  attributes :artist_name, :presentation_order
end
