# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MusicEvents::ListPresenter do
  let!(:music_event) do
    FactoryBot.create(
      :music_event,
      scheduled_date_time: DateTime.parse('20/10/2020 01:30')
    ).decorate
  end

  it 'should return hash object' do
    music_event_sample = MusicEvent.all_in_time_zone('-0300').decorate

    response = MusicEvents::ListPresenter.new(music_event_sample).data

    expect(response.class).to eq(Hash)
  end
end
