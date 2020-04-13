# frozen_string_literal: true

module MusicEvents
  # Class responsable to create a Music Event
  class Creator
    def initialize(attributes)
      @local = attributes.dig(:local)
      @scheduled_date = attributes.dig(:scheduled_date)
      @scheduled_time = attributes.dig(:scheduled_time)
      @genres = attributes.dig(:genres)&.pluck(:genres)
      @artists_list = attributes.dig(:artists)
      @time_zone = attributes.dig(:client_time_zone)
    end

    def call
      ActiveRecord::Base.transaction do
        create_artists
        create_music_event
        associate_music_event_with_artist
        set_presentation_order_in_event
      end

      use_case_response
    end

    private

    def create_artists
      @artists = @artists_list.map do |artist|
        Artist.find_or_create_by(name: artist[:artist])
      end
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
      DateTime.parse("#{@scheduled_date} #{@scheduled_time} #{@time_zone}")
    end

    def event_type
      @artists.count >= 2 ? :festival : :concert
    end

    def associate_music_event_with_artist
      @music_event.artists << @artists
      @music_event.save!
    end

    def set_presentation_order_in_event
      @artists.each do |artist|
        @music_event.music_event_artists
                    .find_by(artist: artist)
                    .update(presentation_order: current_order(artist))
      end
    end

    def current_order(artist)
      @artists_list.find { |row| row[:artist] == artist.name }[:order]
    end

    # Presenter
    def use_case_response
      ListPresenter.new(all_events).data
    end

    def all_events
      MusicEvent.all_in_time_zone(@time_zone)
                .order(:scheduled_date_time).decorate
    end
  end
end
