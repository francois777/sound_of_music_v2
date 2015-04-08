# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.first || CreateAdminService.new.call
puts 'ADMIN USER: ' << user.email

#Instrument.delete_all


if Subcategory.count == 0
  Category.delete_all

  brass      = Category.create(name: 'Brass')
  electronic = Category.create(name: 'Electronic')
  keyboard   = Category.create(name: 'Keyboard')
  percussion = Category.create(name: 'Percussion')
  strings    = Category.create(name: 'Strings')
  woodwind   = Category.create(name: 'Woodwind')

  bowed        = Subcategory.create(name: 'Bowed', category_id: strings.id )
  plucked      = Subcategory.create(name: 'Plucked', category_id: strings.id )
  hit          = Subcategory.create(name: 'Hit', category_id: strings.id )
  other_string = Subcategory.create(name: 'Other string', category_id: strings.id )

  membrabophone = Subcategory.create(name: 'Membrabophone', category_id: percussion.id )
  idiophone     = Subcategory.create(name: 'Idiophone', category_id: percussion.id )

  edge_blown    = Subcategory.create(name: 'Edge blown', category_id: woodwind.id )
  single_reed   = Subcategory.create(name: 'Single reed', category_id: woodwind.id )
  double_reed   = Subcategory.create(name: 'Double reed', category_id: woodwind.id )
  other_woodwind = Subcategory.create(name: 'Other woodwind', category_id: woodwind.id )

  puts "#{Category.count} Categories have been loaded"
  puts "#{Subcategory.count} Subcategories have been loaded"
end

# user = FactoryGirl.create(:user, first_name: 'Nana', last_name: 'Mouskouri')

accordion = Instrument.create( name: 'Accordion',
                               performer_title: 'Accordionist',
                               category: keyboard,
                               subcategory: nil,
                               origin_period: '1822',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
aeolian_harp = Instrument.create( name: 'Accordion',
                               other_names: 'wind harp',
                               performer_title: 'Harpist',
                               category: strings,
                               subcategory: other_string,
                               origin_period: '1600',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
alto_sax = Instrument.create( name: 'Alto saxophone',
                               other_names: '',
                               performer_title: 'Saxist',
                               category: woodwind,
                               subcategory: single_reed,
                               origin_period: '1600',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
dulcimer = Instrument.create( name: 'Appalachian dulcimer',
                               other_names: 'Mountain dulcimer',
                               performer_title: 'Dulcimer player',
                               category: strings,
                               subcategory: plucked,
                               origin_period: 'unknown',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
bagpipes = Instrument.create( name: 'Bagpipes',
                               other_names: '',
                               performer_title: 'Piper',
                               category: woodwind,
                               subcategory: single_reed,
                               origin_period: '14th century',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
balalaika = Instrument.create( name: 'Balalaika',
                               other_names: '',
                               performer_title: 'Balalaika player',
                               category: strings,
                               subcategory: plucked,
                               origin_period: '18th century',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
banjo = Instrument.create( name: 'Banjo',
                               other_names: '',
                               performer_title: 'Banjoist',
                               category: strings,
                               subcategory: plucked,
                               origin_period: '17th century',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
baritone_sax = Instrument.create( name: 'Baritone saxophone',
                               other_names: '',
                               performer_title: 'Saxist',
                               category: woodwind,
                               subcategory: single_reed,
                               origin_period: '',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
baryton = Instrument.create( name: 'Baryton',
                               other_names: '',
                               performer_title: 'Baryton player',
                               category: strings,
                               subcategory: bowed,
                               origin_period: '',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
bass_clarinet = Instrument.create( name: 'Bass clarinet',
                               other_names: '',
                               performer_title: 'Clarinetist',
                               category: woodwind,
                               subcategory: double_reed,
                               origin_period: '',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
bass_drum = Instrument.create( name: 'Bass drum',
                               other_names: '',
                               performer_title: 'Drummer',
                               category: percussion,
                               subcategory: membrabophone,
                               origin_period: '',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
basoon = Instrument.create( name: 'Bassoon',
                               other_names: '',
                               performer_title: 'Bassoonist',
                               category: woodwind,
                               subcategory: double_reed,
                               origin_period: '1712',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
berimbau = Instrument.create( name: 'Berimbau',
                               other_names: '',
                               performer_title: 'Berimbau player',
                               category: strings,
                               subcategory: hit,
                               origin_period: '1712',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
bodhran = Instrument.create( name: 'Bodrán',
                               other_names: '',
                               performer_title: 'Bodran player',
                               category: percussion,
                               subcategory: membrabophone,
                               origin_period: '',
                               approval_status: :submitted,
                               rejection_reason: :not_rejected,
                               created_by: user,
                               approver: nil )
puts "Number of instruments loaded: #{Instrument.count}"

characteristics = Theme.create( subject: :instruments,
                                name: 'Characteristics')
construction    = Theme.create( subject: :instruments,
                                name: 'Construction')
description     = Theme.create( subject: :instruments,
                                name: 'Description')
etymology       = Theme.create( subject: :instruments,
                                name: 'Etymology')
history         = Theme.create( subject: :instruments,
                                name: 'History')
operation       = Theme.create( subject: :instruments,
                                name: 'Operation')
range           = Theme.create( subject: :instruments,
                                name: 'Range')
relevance       = Theme.create( subject: :instruments,
                                name: 'Relevance today')
technique       = Theme.create( subject: :instruments,
                                name: 'Technique')
puts "Number of themes loaded: #{Theme.count}"
