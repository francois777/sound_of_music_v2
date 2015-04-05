FactoryGirl.define do
  
  factory :bowed, class: Subcategory do
    name 'Bowed'
    category { Category.where('name = ?', 'Strings').first || create(:strings) }
  end 

end