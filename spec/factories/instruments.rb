FactoryGirl.define do
  factory :instrument do
    sequence(:name) { |n| "{Instrument_#{n}" }
    category 1
    subcategory 1
    tuned false
    other_names "Some other name"
    origin_period ""
    created_by_id 0
    last_image_id 1
    approval_status 1
    rejection_reason 1
  end

end
