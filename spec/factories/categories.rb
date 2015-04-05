FactoryGirl.define do

  factory :category do
    name 'Strings'
  end

  factory :strings, class: Category do
    name 'Strings'
  end

  factory :percussion, class: Category do
    name 'Percussion'
  end

  factory :electronic, class: Category do
    name 'Electronic'
  end

  factory :woodwind, class: Category do
    name 'Woodwind'
  end
end