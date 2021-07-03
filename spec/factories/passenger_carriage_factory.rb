FactoryBot.define do
  factory :passenger_carriage do
    sequence(:number_of_seats) { |n| n * 50 }

    initialize_with { attributes }
  end
end
