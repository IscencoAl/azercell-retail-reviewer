# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report_structure_category do
    name { Faker::Company.name }
    is_deleted false

    trait :deleted do
      is_deleted true
    end

    factory :report_structure_category_with_elements do
      ignore do
        elements_count 5
      end

      after(:create) do |category, evaluator|
        create_list(:report_structure_element, evaluator.elements_count, :category => category)
      end
    end

  end
end
