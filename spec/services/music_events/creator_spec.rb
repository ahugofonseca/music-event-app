# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MusicEvents::Creator do
  let!(:music_event_json) do
    {
      client_time_zone: '-0300',
      local: 'Street A, 245, Rio de Janeiro, RJ, Brazil',
      scheduled_date: '2020-04-30',
      scheduled_time: '20:30',
      genres: [
        { genres: 'rock' },
        { genres: 'blues' }
      ],
      artists: [
        { order: '1', artist: 'Mauro Henrique' },
        { order: '2', artist: 'Eli Soares' }
      ]
    }
  end

  let!(:creator_service) { MusicEvents::Creator.new(music_event_json).call }

  it 'should create artists' do
    artists = Artist.where(name: ['Mauro Henrique', 'Eli Soares'])

    expect(artists.count).to eq(2)
  end

  it 'should create music event' do
    music_event = MusicEvent.where(
      local: 'Street A, 245, Rio de Janeiro, RJ, Brazil',
      scheduled_date_time: DateTime.parse('2020-04-30 20:30 -0300'),
      genres: %w[rock blues]
    )

    expect(music_event.count).to eq(1)
  end

  it 'should associate music event with artist' do
    artists = Artist.where(name: ['Mauro Henrique', 'Eli Soares'])

    music_event = MusicEvent.where(
      local: 'Street A, 245, Rio de Janeiro, RJ, Brazil',
      scheduled_date_time: DateTime.parse('2020-04-30 20:30 -0300'),
      genres: %w[rock blues]
    )

    music_event_artists = MusicEventArtist.where(
      artist: artists, music_event: music_event
    )

    expect(music_event_artists.count).to eq(2)
  end

  it 'should set presentation order in event' do
    music_event = MusicEvent.where(
      local: 'Street A, 245, Rio de Janeiro, RJ, Brazil',
      scheduled_date_time: DateTime.parse('2020-04-30 20:30 -0300'),
      genres: %w[rock blues]
    )

    order1 = Artist.find_by(name: 'Mauro Henrique')
    order2 = Artist.find_by(name: 'Eli Soares')

    music_event_artists = []

    music_event_artists << MusicEventArtist.find_by(
      artist: order1, music_event: music_event, presentation_order: 1
    )

    music_event_artists << MusicEventArtist.find_by(
      artist: order2, music_event: music_event, presentation_order: 2
    )

    expect(music_event_artists.count).to eq(2)
  end

  it 'should return a hash as response' do
    expect(music_event_json.class).to eq(Hash)
  end
end
