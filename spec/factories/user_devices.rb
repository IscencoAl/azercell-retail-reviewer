# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_device do
    user
    device_id { Faker::Bitcoin.address }
  end
end
