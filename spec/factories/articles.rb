FactoryGirl.define do

  factory :instrument_article, class: Article do
    sequence(:title) { |n| "A historical perspective - version #{n}" }
    publishable { Instrument.first || create(:approved_instrument) }
    body Faker::Lorem.sentence
    author { User.first || create(:user)  }
    theme  { Theme.first || create(:instrument_theme) }
    after(:create) { |article| create(:approved_approval, approvable: article) }
  end

end  