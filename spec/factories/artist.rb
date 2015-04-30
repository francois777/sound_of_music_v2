FactoryGirl.define do
  factory :artist do
    submitted_by { User.user.first || create(:user) }
    born_on Date.today - 32.years
    born_country_code 'za'
    artist_names_attributes  [ { name: 'Abraham',
                                 name_type: 0}, 
                               { name: 'Christopholus',
                                 name_type: 1},
                               { name: 'Rorich',
                                 name_type: 2},
                               { name: 'Abie Randich',
                                 name_type: 3}
                               ]
  end

  factory :approved_artist, class: Artist do
    submitted_by { User.user.first || create(:user) }
    born_on Date.today - 30.years
    born_country_code 'za'
    artist_names_attributes  [ { name: 'Abraham',
                                 name_type: 0}, 
                               { name: 'Christopholus',
                                 name_type: 1},
                               { name: 'Rorich',
                                 name_type: 2},
                               { name: 'Abie Randich',
                                 name_type: 3}
                               ]
    after(:create) { |artist| create(:approved_approval, approvable: artist) }
  end

  factory :submitted_artist, class: Artist do
    submitted_by { User.user.first || create(:user) }
    born_on Date.today - 31.years
    born_country_code 'de'
    artist_names_attributes  [ { name: 'Samantha',
                                 name_type: 0}, 
                               { name: 'Solomon',
                                 name_type: 2}
                               ]
    after(:create) { |artist| create(:submitted_approval, approvable: artist) }
  end

  factory :rejected_artist, class: Artist do
    submitted_by { User.user.first || create(:user) }
    born_on Date.today - 35.years
    born_country_code 'de'
    artist_names_attributes  [ { name: 'Hilda',
                                 name_type: 0}, 
                               { name: 'Heinz',
                                 name_type: 2}
                               ]
    after(:create) { |artist| create(:rejected_approval, approvable: artist) }
  end
end

        
