# frozen_string_literal: true

module Api
  module V1
    # Handle request about Music Event
    class MusicEventsController < ApplicationController
      def index
        @music_events = MusicEvent
                        .all_in_time_zone(params[:client_time_zone])
                        .order(:scheduled_date_time).decorate

        render json: object_serialized
      end

      def create
        @music_events = MusicEvents::Creator.new(music_event_params).call

        render json: @music_events
      end

      private

      def music_event_params
        params.require(:music_event).permit(
          :client_time_zone, :local, :scheduled_date, :scheduled_time,
          genres: [], artists: []
        )
      end

      def object_serialized
        MusicEvents::ListPresenter.new(@music_events).data
      end
    end
  end
end
