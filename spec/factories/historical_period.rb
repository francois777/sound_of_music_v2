FactoryGirl.define do

  factory :historical_period do
    name 'Baroque Period'
    period_from  Date.new(1800,1,1)
    period_end   Date.new(1920,12,31)
    overview 'Something about the Romantic Period'
  end

end  