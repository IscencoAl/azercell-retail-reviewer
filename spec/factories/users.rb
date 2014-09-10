# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email { "#{name}.#{surname}@fakemail.com" }
    password "password"
    password_confirmation "password"
    user_role_id { UserRole.all.to_a.sample.id }
    subscription { [true, false].sample }
    is_deleted false

    trait :admin do
      user_role_id { UserRole.find_by_name("admin").id }
    end

    trait :simple_user do
      user_role_id { UserRole.find_by_name("user").id }
    end

    trait :reviewer do
      user_role_id { UserRole.find_by_name("reviewer").id }
    end

    trait :deleted do
      is_deleted true
    end

    trait :invalid do
      name nil
    end
  end
end
