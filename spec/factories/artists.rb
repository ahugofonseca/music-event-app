# frozen_string_literal: true

FactoryBot.define do
  factory :artist do
    name { Faker::Name.unique.name_with_middle }
  end
end
