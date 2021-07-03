FactoryBot.define do
  factory :train do
    sequence(:number) { |n| "0000#{n}" }

    initialize_with { attributes }
  end
end
