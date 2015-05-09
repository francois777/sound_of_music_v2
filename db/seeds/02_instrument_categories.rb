if Subcategory.count == 0
  
  brass      = Category.create(name: 'Brass')
  electronic = Category.create(name: 'Electronic')
  keyboard   = Category.create(name: 'Keyboard')
  percussion = Category.create(name: 'Percussion')
  strings    = Category.create(name: 'Strings')
  woodwind   = Category.create(name: 'Woodwind')

  bowed        = Subcategory.create(name: 'Bowed', category: strings)
  plucked      = Subcategory.create(name: 'Plucked', category: strings )
  hit          = Subcategory.create(name: 'Hit', category: strings )
  other_string = Subcategory.create(name: 'Other string', category: strings )

  membrabophone = Subcategory.create(name: 'Membrabophone', category: percussion )
  idiophone     = Subcategory.create(name: 'Idiophone', category: percussion )

  edge_blown    = Subcategory.create(name: 'Edge blown', category: woodwind )
  single_reed   = Subcategory.create(name: 'Single reed', category: woodwind )
  double_reed   = Subcategory.create(name: 'Double reed', category: woodwind )
  other_woodwind = Subcategory.create(name: 'Other woodwind', category: woodwind )

  puts "#{Category.count} Categories have been loaded"
  puts "#{Subcategory.count} Subcategories have been loaded"

end
