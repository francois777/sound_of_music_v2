FactoryGirl.define do

  factory :baroque_period, class: HistoricalPeriod do
    name 'Baroque Period'
    period_from  Date.new(1600,1,1)
    period_end   Date.new(1749,12,31)
    overview 'Something about the Romantic Period'
  end

  factory :classical_period, class: HistoricalPeriod do
    name 'Classical Period'
    period_from  Date.new(1750,1,1)
    period_end   Date.new(1819,12,31)
    overview 'Something about the Classical Period'
  end

end  