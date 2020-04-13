# frozen_string_literal: true

module MusicEvents
  # Class responsable to create a Music Event
  class Creator
    def initialize(attributes)
      @local = attributes.dig(:local)
      @scheduled_date = attributes.dig(:scheduled_date)
      @scheduled_time = attributes.dig(:scheduled_time)
      @genres = attributes.dig(:genres)
      @artists_names = attributes.dig(:artists)
    end

    def call
      ActiveRecord::Base.transaction do
        create_artists
        create_music_event
        associate_music_event_with_artist
      end

      use_case_response
    end

    private

    def create_artists
      @artists =
        @artists_names.map { |artist| Artist.find_or_create_by(name: artist) }
    end

    def create_music_event
      @music_event = MusicEvent.create!(
        local: @local,
        scheduled_date_time: scheduled_date_time,
        event_type: event_type,
        genres: @genres
      )
    end

    def scheduled_date_time
      DateTime.parse("#{@scheduled_date} #{@scheduled_time}")
    end

    def event_type
      @artists.count >= 2 ? :festival : :concert
    end

    def associate_music_event_with_artist
      @music_event.artists << @artists
      @music_event.save!
    end

    # Presenter
    def use_case_response
      ListPresenter.new(all_events).data
    end

    def all_events
      MusicEvent.all.order(:scheduled_date_time).decorate
    end
  end
end
