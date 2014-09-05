# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dealer do
    name { Faker::Company.name }
    contact_name { Faker::Name.name }
    phone_number { Faker::Number.number(9)}
    email {Faker::Internet.email}
    is_deleted false

    trait :deleted do
      is_deleted true
    end

    trait :invalid do
      name nil
    end

    
  end
end
