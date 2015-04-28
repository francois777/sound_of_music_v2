FactoryGirl.define do

  factory :tenor, class: ContributionType do
    classification :vocalist
    group_type :individual
    voice_type :tenor
    definition 'The tenor is the highest male voice within the modal register.'
  end

  factory :composer, class: ContributionType do
    classification :composer
    group_type :individual
    voice_type :not_applicable
    definition 'A composer is a person who creates the melody of a musical piece.'
  end

  
  
end