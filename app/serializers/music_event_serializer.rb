# frozen_string_literal: true

# Music Event Serializer Class
class MusicEventSerializer < ActiveModel::Serializer
  attributes :local, :scheduled_date, :scheduled_time, :scheduled_date_time,
             :event_type, :genres, :id

  has_many :artists, serializer: ArtistSerializer
end
