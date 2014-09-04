# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    name { Faker::Address.state}
    region
    is_deleted false

    trait :deleted do
      is_deleted true
    end

    trait :invalid do
      name nil
    end

  end
end

