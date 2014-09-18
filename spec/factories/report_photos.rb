# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report_photo do
    photo "MyString"
    report nil
  end
end
