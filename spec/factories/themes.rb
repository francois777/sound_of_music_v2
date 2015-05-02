FactoryGirl.define do

  factory :instrument_theme, class: Theme do
    subject :instruments
    name 'History'
  end

  factory :artist_theme, class: Theme do
    subject :artists
    name 'History'
  end

end  