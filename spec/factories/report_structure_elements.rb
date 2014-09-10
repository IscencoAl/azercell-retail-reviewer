# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report_structure_element do
    name { Faker::Company.name }
    report_structure_element_type_id { ReportStructureElementType.all.to_a.sample.id }
    association :category, :factory =>  :report_structure_category
    weight { (1..10).to_a.sample }
    shop_types { ["A", "B", "C", "D", "E", "F"].sample }
  end
end
