FactoryGirl.define do
  
  factory :bowed, class: Subcategory do
    name 'Bowed'
    category { Category.where('name = ?', 'Strings').first || create(:strings) }
  end 

  factory :membranophone, class: Subcategory do
    name 'Membranophone'
    category { Category.where('name = ?', 'Percussion').first || create(:percussion) }
  end

  factory :idiophone, class: Subcategory do
    name 'Membrabophone'
    category { Category.where('name = ?', 'Percussion').first || create(:percussion) }
  end

end