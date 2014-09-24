# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    sequence(:name) { |n| "#{Faker::Address.city}_#{n}" }
    region
    is_deleted false

    trait :deleted do
      is_deleted true
    end

    trait :invalid do
      name nil
    end
  end

  factory :city_with_existing_elements, :class => City do
    sequence(:name) { |n| "#{Faker::Address.city}" }
    region { Region.all.to_a.sample }
    is_deleted false

    trait :deleted do
      is_deleted true
    end

    trait :invalid do
      name nil
    end

  end
end