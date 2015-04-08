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
    approver nil
    last_image_id 1
    approval_status :submitted
    rejection_reason :not_rejected
  end

end
