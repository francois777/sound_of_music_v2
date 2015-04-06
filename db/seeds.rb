# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.first || CreateAdminService.new.call
puts 'ADMIN USER: ' << user.email

# Subcategory.delete_all
# Category.delete_all

# Category.create(name: 'Brass')
# Category.create(name: 'Electronic')
# Category.create(name: 'Keyboard')
# percussion_cat = Category.create(name: 'Percussion')
# strings_cat = Category.create(name: 'Strings')
# woodwind_cat = Category.create(name: 'Woodwind')

# Subcategory.create(name: 'Bowed', category_id: strings_cat.id )
# Subcategory.create(name: 'Plucked', category_id: strings_cat.id )
# Subcategory.create(name: 'Hit', category_id: strings_cat.id )
# Subcategory.create(name: 'Other string', category_id: strings_cat.id )

# Subcategory.create(name: 'Membrabophone', category_id: percussion_cat.id )
# Subcategory.create(name: 'Idiophone', category_id: percussion_cat.id )

# Subcategory.create(name: 'Edge blown', category_id: woodwind_cat.id )
# Subcategory.create(name: 'Single reed', category_id: woodwind_cat.id )
# Subcategory.create(name: 'Double reed', category_id: woodwind_cat.id )
# Subcategory.create(name: 'Other woodwind', category_id: woodwind_cat.id )

# puts "#{Category.count} Categories have been loaded"
# puts "#{Subcategory.count} Subcategories have been loaded"

(1..20).each { FactoryGirl.create(:instrument, created_by: user) }
