# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :music_events, only: %i[index create]
    end
  end
end
