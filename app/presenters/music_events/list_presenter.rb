# frozen_string_literal: true

module MusicEvents
  # Grouped by day
  class ListPresenter
    def initialize(music_events)
      @music_events = music_events
    end

    def data
      music_events_data
    end

    private

    def music_events_data
      grouped_by_day.map do |k, v|
        {
          day: k,
          events: v.map { |h| h.except!(:id, :scheduled_date) }
        }
      end
    end

    def grouped_by_day
      object_serialized.group_by { |row| row[:scheduled_date] }
    end

    def object_serialized
      ActiveModelSerializers::SerializableResource.new(
        @music_events, each_serializer: MusicEventSerializer
      ).as_json
    end
  end
end
