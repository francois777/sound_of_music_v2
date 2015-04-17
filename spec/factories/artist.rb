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
end

        
