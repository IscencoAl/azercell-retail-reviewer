# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report do
    created_at { Time.now }
    latitude { rand(38.448265..41.884439) }
    longitude { rand(44.770598..50.365260) }
    association :user, :factory => [:user, :reviewer]
    shop
    score { rand(0..5.0) }

    trait :existing_references do
      user { UserRole.reviewer.users.sample }
      shop { Shop.all.to_a.sample }
    end
  end

  factory :exisiting_report_with_elements, :class => Report do
    created_at { Time.now }
    latitude { rand(38.448265..41.884439) }
    longitude { rand(44.770598..50.365260) }
    user { UserRole.reviewer.users.sample }
    shop { Shop.all.to_a.sample }
    score { rand(0..5.0) }

    after(:create) do |report, evaluator|
      ReportStructureElement.all.each do |elem|
        create(:report_element, :name => elem.name, :report_structure_element_type_id => elem.type.id,
          :category => elem.category, :report => report)
      end
    end
  end
end
