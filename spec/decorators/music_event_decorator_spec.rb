# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MusicEventDecorator do
  let!(:music_event) do
    FactoryBot.create(
      :music_event,
      scheduled_date_time: DateTime.parse('20/10/2020 01:30')
    ).decorate
  end

  it 'should music_event decorated' do
    expect(music_event).to be_decorated
  end

  # Respond to validations
  it { expect(music_event).to respond_to(:scheduled_date) }
  it { expect(music_event).to respond_to(:scheduled_time) }

  context 'when timezone was converted' do
    it 'should return scheduled_date with converted Date UTC to localtime' do
      music_event_sample = MusicEvent.all_in_time_zone('-0300').first.decorate
      expect(music_event_sample.scheduled_date).to eq('10/19/2020')
    end

    it 'should return scheduled_date with converted Time UTC to localtime' do
      music_event_sample = MusicEvent.all_in_time_zone('-0300').first.decorate
      expect(music_event_sample.scheduled_time).to eq('22:30:00')
    end
  end

  context 'when timezone default (UTC)' do
    it 'should return default Data in UTC' do
      expect(music_event.scheduled_date).to eq('10/20/2020')
    end

    it 'should return default Time in UTC' do
      expect(music_event.scheduled_time).to eq('01:30:00')
    end
  end
end
