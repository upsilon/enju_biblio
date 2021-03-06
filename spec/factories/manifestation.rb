FactoryGirl.define do
  factory :manifestation do |f|
    f.sequence(:original_title){|n| "manifestation_title_#{n}"}
    f.carrier_type_id{CarrierType.find(1).id}
  end

  factory :manifestation_serial, class: Manifestation do |f|
    f.sequence(:original_title){|n| "manifestation_title_#{n}"}
    f.carrier_type_id{CarrierType.find(1).id}
    f.language_id{Language.find(1).id}
    f.serial{true}
    f.series_statements{[FactoryGirl.create(:series_statement_serial)]}
  end
end
