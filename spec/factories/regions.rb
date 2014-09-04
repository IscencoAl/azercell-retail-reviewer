# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :region do
    name { Faker::Address.state}
    is_deleted false

    trait :deleted do
      is_deleted true
    end

    trait :invalid do
      name nil
    end

    trait :admin do
      user_role_id { UserRole.find_by_name("admin").id }
    end

    trait :simple_user do
      user_role_id { UserRole.find_by_name("user").id }
    end



  end
end
