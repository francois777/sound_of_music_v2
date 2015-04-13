# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# CreateAdminService.new.call
# puts 'ADMIN USER: ' << user.email
if User.count == 0
  admin = User.create(
      password: Rails.application.secrets.admin_password,
      password_confirmation: Rails.application.secrets.admin_password,
      first_name: 'Admin',
      last_name: 'Administrator',
      admin: true,
      role: 2,
      email: Rails.application.secrets.admin_email,
      confirmed_at: Time.now)

  approver = User.create(
      password: Rails.application.secrets.admin_password,
      password_confirmation: Rails.application.secrets.admin_password,
      first_name: 'Anthony',
      last_name: 'Approver',
      role: 1,
      email: Rails.application.secrets.approver_email,
      confirmed_at: Time.now)

  owner = User.create(
      password: Rails.application.secrets.admin_password,
      password_confirmation: Rails.application.secrets.admin_password,
      first_name: 'Olivia',
      last_name: 'Owner',
      role: 2,
      email: Rails.application.secrets.owner_email,
      confirmed_at: Time.now)
      
  user = User.create(
      password: Rails.application.secrets.admin_password,
      password_confirmation: Rails.application.secrets.admin_password,
      first_name: 'Ursula',
      last_name: 'User',
      role: 0,
      email: Rails.application.secrets.user_email,
      confirmed_at: Time.now)
end

user = User.where('last_name = ?', 'User').first
approver = User.where('last_name = ?', 'Owner').first
owner = User.where('last_name = ?', 'Owner').first

puts "#{User.count} Users have been loaded"

Article.delete_all
Instrument.delete_all
Subcategory.delete_all
Category.delete_all
if Subcategory.count == 0
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
if Instrument.count == 0
  accordion = Instrument.create( name: 'Accordion',
                                 performer_title: 'Accordionist',
                                 category: keyboard,
                                 subcategory: nil,
                                 origin_period: '1822',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  aeolian_harp = Instrument.create( name: 'Accordion',
                                 other_names: 'wind harp',
                                 performer_title: 'Harpist',
                                 category: strings,
                                 subcategory: other_string,
                                 origin_period: '1600',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  alto_sax = Instrument.create( name: 'Alto saxophone',
                                 other_names: '',
                                 performer_title: 'Saxist',
                                 category: woodwind,
                                 subcategory: single_reed,
                                 origin_period: '1600',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  dulcimer = Instrument.create( name: 'Appalachian dulcimer',
                                 other_names: 'Mountain dulcimer',
                                 performer_title: 'Dulcimer player',
                                 category: strings,
                                 subcategory: plucked,
                                 origin_period: 'unknown',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  bagpipes = Instrument.create( name: 'Bagpipes',
                                 other_names: '',
                                 performer_title: 'Piper',
                                 category: woodwind,
                                 subcategory: single_reed,
                                 origin_period: '14th century',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  balalaika = Instrument.create( name: 'Balalaika',
                                 other_names: '',
                                 performer_title: 'Balalaika player',
                                 category: strings,
                                 subcategory: plucked,
                                 origin_period: '18th century',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  banjo = Instrument.create( name: 'Banjo',
                                 other_names: '',
                                 performer_title: 'Banjoist',
                                 category: strings,
                                 subcategory: plucked,
                                 origin_period: '17th century',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  baritone_sax = Instrument.create( name: 'Baritone saxophone',
                                 other_names: '',
                                 performer_title: 'Saxist',
                                 category: woodwind,
                                 subcategory: single_reed,
                                 origin_period: '',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  baryton = Instrument.create( name: 'Baryton',
                                 other_names: '',
                                 performer_title: 'Baryton player',
                                 category: strings,
                                 subcategory: bowed,
                                 origin_period: '',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  bass_clarinet = Instrument.create( name: 'Bass clarinet',
                                 other_names: '',
                                 performer_title: 'Clarinetist',
                                 category: woodwind,
                                 subcategory: double_reed,
                                 origin_period: '',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  bass_drum = Instrument.create( name: 'Bass drum',
                                 other_names: '',
                                 performer_title: 'Drummer',
                                 category: percussion,
                                 subcategory: membrabophone,
                                 origin_period: '',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  basoon = Instrument.create( name: 'Bassoon',
                                 other_names: '',
                                 performer_title: 'Bassoonist',
                                 category: woodwind,
                                 subcategory: double_reed,
                                 origin_period: '1712',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  berimbau = Instrument.create( name: 'Berimbau',
                                 other_names: '',
                                 performer_title: 'Berimbau player',
                                 category: strings,
                                 subcategory: hit,
                                 origin_period: '1712',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
  bodhran = Instrument.create( name: 'Bodrán',
                                 other_names: '',
                                 performer_title: 'Bodran player',
                                 category: percussion,
                                 subcategory: membrabophone,
                                 origin_period: '',
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected,
                                 created_by_id: user.id,
                                 approver: nil )
end

puts "Number of instruments loaded: #{Instrument.count}"

if Theme.count == 0
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
end

puts "Number of themes loaded: #{Theme.count}"

characteristics = Theme.where("name = ?", 'Characteristics').first
construction = Theme.where("name = ?", 'Construction').first
description = Theme.where("name = ?", 'Description').first
etymology = Theme.where("name = ?", 'Etymology').first
history = Theme.where("name = ?", 'History').first
operation = Theme.where("name = ?", 'Operation').first
range = Theme.where("name = ?", 'Range').first
relevance = Theme.where("name = ?", 'Relevance').first
technique = Theme.where("name = ?", 'Technique').first

puts "Number of themes loaded: #{Theme.count}"

lorem1 = "Crinis verus versus appositus voluptatem cena ambitus non. Tandem vomica cursus. Pariatur bis accusator vultuosus. Dolores reprehenderit trans defluo conor. Cursim attollo voluptatem thymbra solum tot tres. Vilicus decerno valens decimus cicuta. Vae cum molestiae bellicus aqua animi demergo. Aeternus aduro pax vergo odit crinis derideo."
lorem2 = "Stipes auris appositus vilicus cavus absconditus thema dedecor. Aperte spero curis depono sui. Atrox stipes comprehendo uredo sonitus arbitro clementia. Despecto bellicus cauda cursim conturbo. Fugiat chirographum aer sono benevolentia. Unde cohibeo in patria temeritas tero tenus. Tener vita dapifer tabula."
lorem3 = "Totidem fugiat ipsa assumenda deporto nulla accedo contra. Occaecati curiositas molestiae. Calco ut laudantium vae tandem acies deserunt acerbitas. Sint vapulus vitium defungo veritas. Voluptatem curso uredo error pecto ipsa. Vae truculenter ipsam expedita tabernus alii cicuta ultra. Bardus modi ars talus non inflammatio."
lorem4 = "Anser doloremque corona altus aegrus eos. Articulus careo est capillus claustrum depromo. Careo vereor verto tego acer. Depereo sit defessus venia validus. Solvo calcar apparatus inflammatio teneo contigo tardus copiose. Vester adaugeo consuasor. Ulciscor aut non volutabrum voluptatum tamisium. Qui ulciscor taedium quis angustus thesaurus colloco adsidue."
lorem5 = "Casso voluptates cunabula victoria adaugeo desidero tres. Astrum utpote tabgo soluta odit terminatio. Accipio omnis basium cometes. Tero tardus aer cilicium annus constans. Arbitro defluo addo ipsum armo quia sub. Vigor aperte cohaero illo sub tendo laudantium adeptio. Temeritas iste stipes viduata eum. Nihil claro confido dolores totus eius utroque antepono."
lorem6 = "Ultio advoco torqueo trucido aiunt triduana defetiscor. Ocer calamitas sponte at ipsum armo triginta aer. Patria uberrime cuius. Triginta degenero quae laboriosam speculum uredo. Architecto est amaritudo vetus. Vitiosus spargo iure corroboro voluptatem culpa adhuc quisquam. Ulterius carus bardus totus vinitor. Vulgivagus comprehendo terreo synagoga assentator. Sono vallum texo aegrus vulgo conventus ara deputo."

Article.delete_all
Instrument.all.each do |ins|
  art1 = Article.create!(title: "The early history of #{ins.name}", publishable: ins, approver: nil,
    body: lorem1, author: user, theme: description,
    approval_status: :incomplete, rejection_reason: :not_rejected)
  puts "Article name: #{art1.title}"
  art2 = Article.create!(title: "The meaning of #{ins.name}", publishable: ins, approver: nil,
    body: lorem2, author: user, theme: etymology,
    approval_status: :submitted, rejection_reason: :not_rejected)
  puts "Article name: #{art2.title}"
  art3 = Article.create!(title: "The construction of #{ins.name}", publishable: ins, approver: approver,
    body: lorem3, author: user, theme: construction,
    approval_status: :submitted, rejection_reason: :not_rejected)
  puts "Article name: #{art3.title}"
  art4 = Article.create!(title: "The history of #{ins.name}", publishable: ins, approver: approver,
    body: lorem4, author: user, theme: history,
    approval_status: :approved, rejection_reason: :not_rejected)
  puts "Article name: #{art4.title}"
  art5 = Article.create!(title: "The operation of #{ins.name}", publishable: ins, approver: approver,
    body: lorem5, author: user, theme: operation,
    approval_status: :approved, rejection_reason: :not_rejected)
  puts "Article name: #{art5.title}"
  art6 = Article.create!(title: "Techniques to play the #{ins.name}", publishable: ins, approver: approver,
    body: lorem6, author: user, theme: technique,
    approval_status: :to_be_revised, rejection_reason: :grammar_and_spelling)
  puts "Article name: #{art6.title}"
end
