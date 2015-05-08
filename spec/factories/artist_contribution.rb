FactoryGirl.define do

# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
  factory :artist_contribution do
    artist { Artist.approved.first || create(:approved_artist) }
    contribution_type { ContributionType.first || create(:contribution_type)}
    comment { "#{artist.name} appreciates the talent of #{contribution_type.name}" }
  end

end    