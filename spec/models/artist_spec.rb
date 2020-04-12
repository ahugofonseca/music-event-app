require 'rails_helper'

RSpec.describe Artist, type: :model do
  let(:artist) { FactoryBot.build_stubbed(:artist) }

  # Respond_to validations
  it { is_expected.to respond_to(:name) }

  # Presence validations
  it { is_expected.to validate_presence_of(:name) }

  # Uniqueness validations
  it { is_expected.to validate_uniqueness_of(:name) }
end
