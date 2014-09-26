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
    association :user, :factory => [:user, :reviewer] 
    is_deleted false
    score { rand(0..5) }

    trait :invalid do
      address nil
    end

    trait :deleted do
      is_deleted true
    end
  end

  factory :shop_with_existing_elements, :class => Shop do
    shop_type_id { ShopType.all.to_a.sample.id }
    city { City.all.to_a.sample }
    address { Faker::Address.street_address }
    latitude { rand(38.448265..41.884439) }
    longitude { rand(44.770598..50.365260) }
    dealer { Dealer.all.to_a.sample }
    square_footage { Faker::Number.number(3) }
    user { UserRole.reviewer.users.to_a.sample }
    is_deleted false

    trait :invalid do
      address nil
    end

    trait :deleted do
      is_deleted true
    end
  end
end