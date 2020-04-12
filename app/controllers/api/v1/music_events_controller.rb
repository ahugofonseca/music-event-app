# frozen_string_literal: true

module Api
  module V1
    # Handle request about Music Event
    class MusicEventsController < ApplicationController
      def index
        @music_events = MusicEvent.all.order(:scheduled_date_time).decorate

        render json: object_serialized
      end

      private

      def object_serialized
        MusicEvents::ListPresenter.new(@music_events).data
      end
    end
  end
end
