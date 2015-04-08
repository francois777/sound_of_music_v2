FactoryGirl.define do

  factory :instrument_article, class: Article do
    sequence(:title) { |n| "A historical perspective - version #{n}" }
    publishable { Instrument.first || create(:string_instrument) }
    body Faker::Lorem.sentence
    approver nil
    author { User.first || create(:user)  }
    theme  { Theme.first || create(:instrument_theme) }
    approval_status :submitted
    rejection_reason :not_rejected
  end

end  