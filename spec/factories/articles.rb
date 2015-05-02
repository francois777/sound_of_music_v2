FactoryGirl.define do

  factory :incomplete_instrument_article, class: Article do
    sequence(:title) { |n| "A historical perspective - version #{n}" }
    publishable { Instrument.first || create(:approved_instrument) }
    body Faker::Lorem.sentence
    author { User.first || create(:user)  }
    theme  { Theme.instruments.first || create(:instrument_theme) }
    after(:create) { |article| create(:incomplete_approval, approvable: article) }
  end

  factory :submitted_instrument_article, class: Article do
    sequence(:title) { |n| "A historical perspective - version #{n}" }
    publishable { Instrument.first || create(:approved_instrument) }
    body Faker::Lorem.sentence
    author { User.first || create(:user)  }
    theme  { Theme.instruments.first || create(:instrument_theme) }
    after(:create) { |article| create(:submitted_approval, approvable: article) }
  end

  factory :approved_instrument_article, class: Article do
    sequence(:title) { |n| "A historical perspective - version #{n}" }
    publishable { Instrument.first || create(:approved_instrument) }
    body Faker::Lorem.sentence
    author { User.first || create(:user)  }
    theme  { Theme.instruments.first || create(:instrument_theme) }
    after(:create) { |article| create(:approved_approval, approvable: article) }
  end

  factory :incomplete_artist_article, class: Article do
    sequence(:title) { |n| "A historical perspective - version #{n}" }
    publishable { Artist.first || create(:approved_artist) }
    body Faker::Lorem.sentence
    author { User.first || create(:user)  }
    theme  { Theme.artists.first || create(:artist_theme) }
    after(:create) { |article| create(:incomplete_approval, approvable: article) }
  end

  factory :submitted_artist_article, class: Article do
    sequence(:title) { |n| "A historical perspective - version #{n}" }
    publishable { Artist.first || create(:approved_artist) }
    body Faker::Lorem.sentence
    author { User.first || create(:user)  }
    theme  { Theme.artists.first || create(:artist_theme) }
    after(:create) { |article| create(:submitted_approval, approvable: article) }
  end

  factory :approved_artist_article, class: Article do
    sequence(:title) { |n| "A historical perspective - version #{n}" }
    publishable { Artist.first || create(:approved_artist) }
    body Faker::Lorem.sentence
    author { User.first || create(:user)  }
    theme  { Theme.artists.first || create(:artist_theme) }
    after(:create) { |article| create(:approved_approval, approvable: article) }
  end

  factory :rejected_artist_article, class: Article do
    sequence(:title) { |n| "A historical perspective - version #{n}" }
    publishable { Artist.first || create(:approved_artist) }
    body Faker::Lorem.sentence
    author { User.first || create(:user)  }
    theme  { Theme.artists.first || create(:artist_theme) }
    after(:create) { |article| create(:rejected_approval, approvable: article) }
  end

end  