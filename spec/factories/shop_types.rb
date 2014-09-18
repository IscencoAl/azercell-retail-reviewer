# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shop_type do
    sequence(:name) { |n| "#{Faker::Lorem.word}_#{n}" }
    sequence(:abbreviation) { |n| "#{['A', 'B', 'C', 'D'].sample}#{n}" }
    is_deleted false

    trait :deleted do
      is_deleted true
    end

    trait :invalid do
      name nil
    end
  end
end
