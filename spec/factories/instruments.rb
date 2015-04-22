FactoryGirl.define do
  factory :submitted_instrument, class: Instrument do
    sequence(:name) { |n| "Submitted Instrument_#{n}" }
    category Category.where("name = ?", 'Strings').first
    subcategory Subcategory.where("name = ?", 'Bowed').first
    performer_title 'Harpist'
    tuned false
    other_names "Some other name"
    origin_period ""
    created_by { User.user.first || create(:user) }
    last_image_id 1
    after(:create) { |instrument| create(:submitted_approval, approvable: instrument) }
  end

  factory :approved_instrument, class: Instrument do
    sequence(:name) { |n| "Approved Instrument_#{n}" }
    category Category.where("name = ?", 'Strings').first
    subcategory Subcategory.where("name = ?", 'Bowed').first
    performer_title 'Harpist'
    tuned false
    other_names "Some other name"
    origin_period ""
    created_by { User.user.first || create(:user) }
    last_image_id 1
    after(:create) { |instrument| create(:approved_approval, approvable: instrument) }
  end

  factory :rejected_instrument, class: Instrument do
    sequence(:name) { |n| "Rejected Instrument_#{n}" }
    category Category.where("name = ?", 'Strings').first
    subcategory Subcategory.where("name = ?", 'Bowed').first
    performer_title 'Harpist'
    tuned false
    other_names "Some other name"
    origin_period ""
    created_by { User.user.first || create(:user) }
    last_image_id 1
    after(:create) { |instrument| create(:rejected_approval, approvable: instrument) }
  end

  factory :triangle, class: Instrument do
    name "Triangle"
    category { Category.where("name = ?", 'Percussion').first || create(:percussion) }
    subcategory { Subcategory.where("name = ?", 'Idiophone').first || create(:idiophone) }
    performer_title 'Percussionist'
    tuned false
    other_names ""
    origin_period "10th century"
    created_by { User.user.first || create(:user) }
    last_image_id 0
    after(:create) { |instrument| create(:approved_approval, approvable: instrument) }
  end    

  factory :symbols, class: Instrument do
    name "Symbols"
    category { Category.where("name = ?", 'Percussion').first || create(:percussion) }
    subcategory { Subcategory.where("name = ?", 'Idiophone').first || create(:idiophone) }
    performer_title 'Percussionist'
    tuned false
    other_names ""
    origin_period "10th century"
    created_by { User.user.first || create(:user) }
    last_image_id 0
    after(:create) { |instrument| create(:approved_approval, approvable: instrument) }
  end    

end
