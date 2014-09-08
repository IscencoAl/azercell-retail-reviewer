# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report_structure_category do
    name { Faker::Company.name }
  end
end
