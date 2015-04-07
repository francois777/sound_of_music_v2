FactoryGirl.define do

  factory :instrument_article, class: Article do
    sequence(:title) { |n| "A historical perspective - version #{n}" }
    publishable { Instrument.first || create(:string_instrument) }
    body "Lorem ipsum..."
    author { create(:user)  }
    theme  { create(:theme) }
    approval_status :submitted
    rejection_status :not_rejected
  end

end  