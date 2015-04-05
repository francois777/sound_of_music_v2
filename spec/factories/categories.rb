FactoryGirl.define do

  factory :category do
    name 'Strings'
  end

  factory :strings, class: Category do
    name 'Strings'
  end

end