FactoryGirl.define do
  factory :instrument do
    sequence(:name) { |n| "Instrument_#{n}" }
    category Category.where("name = ?", 'Strings').first
    subcategory Subcategory.where("name = ?", 'Bowed').first
    performer_title 'Harpist'
    tuned false
    other_names "Some other name"
    origin_period ""
    created_by nil
    last_image_id 1
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
  end    

end
