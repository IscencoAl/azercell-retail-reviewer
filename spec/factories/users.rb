# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email { "#{name}.#{surname}@fakemail.com" }
    password "password"
    role { UserRole.all.to_a.sample }
    subscription { [true, false].sample }
    is_deleted false

    trait :deleted do
      is_deleted true
    end
  end
end
