# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MusicEvent, type: :model do
  let(:music_event) { FactoryBot.build_stubbed(:music_event) }

  # Respond_to validations
  it { is_expected.to respond_to(:local) }
  it { is_expected.to respond_to(:scheduled_date_time) }
  it { is_expected.to respond_to(:event_type) }
  it { is_expected.to respond_to(:genres) }

  # Presence validations
  it { is_expected.to validate_presence_of(:local) }
  it { is_expected.to validate_presence_of(:scheduled_date_time) }
  it { is_expected.to validate_presence_of(:event_type) }
  it { is_expected.to validate_presence_of(:genres) }
end
