# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :region do
    name { Faker::Address.state}
    is_deleted false

    trait :deleted do
      is_deleted true
    end

  end
end
