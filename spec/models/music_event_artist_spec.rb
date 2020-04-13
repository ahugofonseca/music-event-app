# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MusicEventArtist, type: :model do
  let(:music_event_artist) { FactoryBot.create(:music_event_artist) }

  # Respond_to validations
  it { is_expected.to respond_to(:artist_id) }
  it { is_expected.to respond_to(:music_event_id) }
  it { is_expected.to respond_to(:presentation_order) }

  # Presence validations
  it { is_expected.to validate_presence_of(:presentation_order) }

  # Uniqueness validations
  it { expect(music_event_artist).to validate_uniqueness_of(:artist_id).scoped_to(:music_event_id) }
end
