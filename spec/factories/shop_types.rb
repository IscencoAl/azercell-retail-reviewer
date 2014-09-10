# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shop_type do
    name {Faker::Lorem.word}
  
    sequence(:abbreviation) { |n| "A#{n}" }
    is_deleted false

    trait :deleted do
      is_deleted true
    end

    trait :invalid do
      name nil
    end
  end
end
