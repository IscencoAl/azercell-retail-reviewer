# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee do
    name {Faker::Name.name }
    phone { Faker::Number.number(9)}
    email { Faker::Internet.email }
    shop
    employee_workposition
    is_deleted false

    trait :deleted do
      is_deleted true
    end

    trait :invalid do
      name nil
    end
  end
end
