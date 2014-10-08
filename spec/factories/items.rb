# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name { Faker::Commerce.product_name}
    is_deleted false

    trait :deleted do
      is_deleted true
    end
  end

end