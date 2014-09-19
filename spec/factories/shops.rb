# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shop do
    association :type, :factory => [:shop_type]
    city
    address { Faker::Address.street_address }
    latitude { rand(38.448265..41.884439) }
    longitude { rand(44.770598..50.365260) }
    dealer
    square_footage { Faker::Number.number(3) }
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
