FactoryBot.define do
  factory :station do
    sequence(:name) { |n| "Station name #{n}" }

    initialize_with { new(name) }
  end
end
