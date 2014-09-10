# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shop do
    shop_type
    city
    address {Faker::Address.street_address}
    latitude {Faker::Address.latitude }
    longitude {Faker::Address.longitude}
    dealer
    square_footage {Faker::Number.number(3)}
    user
    is_deleted false

    trait :invalid do
      address nil
    end

    trait :deleted do
      is_deleted true
    end

  end
end
