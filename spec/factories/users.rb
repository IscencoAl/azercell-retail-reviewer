# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email { "#{name}.#{surname}@fakemail.com" }
    password "password"
    password_confirmation "password"
    user_role_id { 
      roles = UserRole.pluck(:id)
      roles.delete(UserRole.dealer.id)
      roles.sample }
    subscription { [true, false].sample }
    is_deleted false

    trait :admin do
      user_role_id { UserRole.admin.id }
    end

    trait :simple_user do
      user_role_id { UserRole.user.id }
    end

    trait :reviewer do
      user_role_id { UserRole.reviewer.id }
    end

    trait :user_dealer do
      user_role_id { UserRole.dealer.id }
      dealer
    end

    trait :deleted do
      is_deleted true
    end

    trait :invalid do
      name nil
    end
  end
end
