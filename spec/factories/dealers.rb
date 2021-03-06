# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dealer do
    sequence(:name) { |n| "#{Faker::Company.name}_#{n}" }
    contact_name { Faker::Name.name }
    phone_number { Faker::Number.number(9)}
    email { Faker::Internet.email }
    is_deleted false
    score { rand(0..5) }

    trait :deleted do
      is_deleted true
    end

    trait :invalid do
      name nil
    end

    
  end
end
