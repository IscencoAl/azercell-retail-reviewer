# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :report_element do
    name { Faker::Lorem.sentence }
    report_structure_element_type_id { ReportStructureElementType.all.to_a.sample.id }
    association :category, :factory => [:report_structure_category]
    report

    value { 
      if report_structure_element_type_id == ReportStructureElementType.mark.id
        (0..5).to_a.sample
      elsif report_structure_element_type_id == ReportStructureElementType.check.id
        ['yes', 'no'].sample
      else
        Faker::Lorem.sentence
      end
    }
  end

  factory :existing_report_element, :class => ReportElement do
    ignore do
      rep_str_elem { ReportStructureElement.all.to_a.sample }
    end

    name { rep_str_elem.name }
    report_structure_category_id { rep_str_elem.category.id }
    report_structure_element_type_id { rep_str_elem.type.id }
    report { Report.all.to_a.sample }

    value { 
      if report_structure_element_type_id == ReportStructureElementType.mark.id
        (0..5).to_a.sample
      elsif report_structure_element_type_id == ReportStructureElementType.check.id
        ['yes', 'no'].sample
      else
        Faker::Lorem.sentence
      end
    }
  end

end
