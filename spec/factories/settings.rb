# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setting do
    name { Faker::Lorem.word }
    value { Faker::Lorem.word }
  end
end
