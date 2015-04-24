# require 'factory_girl_rails' # cannot do this in production

# User.delete_all
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
approver = User.where('last_name = ?', 'Approver').first
owner = User.where('last_name = ?', 'Owner').first

puts "#{User.count} Users have been loaded"

Approval.delete_all
Article.delete_all
Instrument.delete_all
# Subcategory.delete_all
# Category.delete_all

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
end

brass      = Category.where("name = ?", 'Brass').first
electronic = Category.where("name = ?", 'Electronic').first
keyboard   = Category.where("name = ?", 'Keyboard').first
percussion = Category.where("name = ?", 'Percussion').first
strings    = Category.where("name = ?", 'Strings').first
woodwind   = Category.where("name = ?", 'Woodwind').first
brass      = Category.where("name = ?", 'Brass').first
bowed      = Subcategory.where("name = ?", 'Bowed').first
plucked    = Subcategory.where("name = ?", 'Plucked').first
hit        = Subcategory.where("name = ?", 'Hit').first
other_string   = Subcategory.where("name = ?", 'Other string').first
membrabophone  = Subcategory.where("name = ?", 'Membrabophone').first
idiophone      = Subcategory.where("name = ?", 'Idiophone').first
edge_blown     = Subcategory.where("name = ?", 'Edge blown').first
double_reed    = Subcategory.where("name = ?", 'Double reed').first
other_woodwind = Subcategory.where("name = ?", 'Other woodwind').first

puts "#{Category.count} Categories have been loaded"
puts "#{Subcategory.count} Subcategories have been loaded"

if Instrument.count == 0
  accordion = Instrument.create( name: 'Accordion',
                                 performer_title: 'Accordionist',
                                 category: keyboard,
                                 subcategory: nil,
                                 origin_period: '1822',
                                 created_by: user )
  Approval.create(approvable: accordion, approval_status: :submitted, rejection_reason: :not_rejected)

  aeolian_harp = Instrument.create( name: 'Accordion',
                                 other_names: 'wind harp',
                                 performer_title: 'Harpist',
                                 category: strings,
                                 subcategory: other_string,
                                 origin_period: '1600',
                                 created_by: user )
  Approval.create(approvable: aeolian_harp, approval_status: :submitted, rejection_reason: :not_rejected)

  alto_sax = Instrument.create( name: 'Alto saxophone',
                                 other_names: '',
                                 performer_title: 'Saxist',
                                 category: woodwind,
                                 subcategory: single_reed,
                                 origin_period: '1600',
                                 created_by: user)
  Approval.create(approvable: alto_sax, approval_status: :submitted, rejection_reason: :not_rejected)

  dulcimer = Instrument.create( name: 'Appalachian dulcimer',
                                 other_names: 'Mountain dulcimer',
                                 performer_title: 'Dulcimer player',
                                 category: strings,
                                 subcategory: plucked,
                                 origin_period: 'unknown',
                                 created_by: user )
  Approval.create(approvable: dulcimer, approval_status: :submitted, rejection_reason: :not_rejected)

  bagpipes = Instrument.create( name: 'Bagpipes',
                                 other_names: '',
                                 performer_title: 'Piper',
                                 category: woodwind,
                                 subcategory: single_reed,
                                 origin_period: '14th century',
                                 created_by: user )
  Approval.create(approvable: bagpipes, approval_status: :submitted, rejection_reason: :not_rejected)

  balalaika = Instrument.create( name: 'Balalaika',
                                 other_names: '',
                                 performer_title: 'Balalaika player',
                                 category: strings,
                                 subcategory: plucked,
                                 origin_period: '18th century',
                                 created_by: user )
  Approval.create(approvable: balalaika, approval_status: :submitted, rejection_reason: :not_rejected)

  banjo = Instrument.create( name: 'Banjo',
                                 other_names: '',
                                 performer_title: 'Banjoist',
                                 category: strings,
                                 subcategory: plucked,
                                 origin_period: '17th century',
                                 created_by: user )
  Approval.create(approvable: banjo, approval_status: :submitted, rejection_reason: :not_rejected)

  baritone_sax = Instrument.create( name: 'Baritone saxophone',
                                 other_names: '',
                                 performer_title: 'Saxist',
                                 category: woodwind,
                                 subcategory: single_reed,
                                 origin_period: '',
                                 created_by: user )
  Approval.create(approvable: baritone_sax, approval_status: :submitted, rejection_reason: :not_rejected)

  baryton = Instrument.create( name: 'Baryton',
                                 other_names: '',
                                 performer_title: 'Baryton player',
                                 category: strings,
                                 subcategory: bowed,
                                 origin_period: '',
                                 created_by: user )
  Approval.create(approvable: baryton, approval_status: :submitted, rejection_reason: :not_rejected)

  bass_clarinet = Instrument.create( name: 'Bass clarinet',
                                 other_names: '',
                                 performer_title: 'Clarinetist',
                                 category: woodwind,
                                 subcategory: double_reed,
                                 origin_period: '',
                                 created_by: user )
  Approval.create(approvable: bass_clarinet, approval_status: :submitted, rejection_reason: :not_rejected)

  bass_drum = Instrument.create( name: 'Bass drum',
                                 other_names: '',
                                 performer_title: 'Drummer',
                                 category: percussion,
                                 subcategory: membrabophone,
                                 origin_period: '',
                                 created_by: user )
  Approval.create(approvable: bass_drum, approval_status: :submitted, rejection_reason: :not_rejected)

  basoon = Instrument.create( name: 'Bassoon',
                                 other_names: '',
                                 performer_title: 'Bassoonist',
                                 category: woodwind,
                                 subcategory: double_reed,
                                 origin_period: '1712',
                                 created_by: user )
  Approval.create(approvable: basoon, approval_status: :submitted, rejection_reason: :not_rejected)

  berimbau = Instrument.create( name: 'Berimbau',
                                 other_names: '',
                                 performer_title: 'Berimbau player',
                                 category: strings,
                                 subcategory: hit,
                                 origin_period: '1712',
                                 created_by: user )
  Approval.create(approvable: berimbau, approval_status: :submitted, rejection_reason: :not_rejected)

  bodhran = Instrument.create( name: 'Bodrán',
                                 other_names: '',
                                 performer_title: 'Bodran player',
                                 category: percussion,
                                 subcategory: membrabophone,
                                 origin_period: '',
                                 created_by: user )
  Approval.create(approvable: bodhran, approval_status: :submitted, rejection_reason: :not_rejected)

end

puts "Number of instruments loaded: #{Instrument.count}"

if Theme.instruments.count == 0
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

puts "Number of instrument themes loaded: #{Theme.instruments.count}"

characteristics = Theme.where("name = ?", 'Characteristics').first
construction = Theme.where("name = ?", 'Construction').first
description = Theme.where("name = ?", 'Description').first
etymology = Theme.where("name = ?", 'Etymology').first
history = Theme.where("name = ?", 'History').first
operation = Theme.where("name = ?", 'Operation').first
range = Theme.where("name = ?", 'Range').first
relevance = Theme.where("name = ?", 'Relevance').first
technique = Theme.where("name = ?", 'Technique').first

if Theme.artists.count == 0
  artist_biography = Theme.create( subject: :artists,
                                  name: 'Biography')
  artist_overview  = Theme.create( subject: :artists,
                                  name: 'Overview')
  artist_achievements  = Theme.create( subject: :artists,
                                  name: 'Achievements')
  artist_character  = Theme.create( subject: :artists,
                                  name: 'Character')
  artist_legacy  = Theme.create( subject: :artists,
                                  name: 'Legacy')
  artist_musical_style  = Theme.create( subject: :artists,
                                  name: 'Musical style')
  artist_influences  = Theme.create( subject: :artists,
                                  name: 'Influences')
  artist_career  = Theme.create( subject: :artists,
                                  name: 'Career')
  artist_recognition  = Theme.create( subject: :artists,
                                  name: 'Recognition and Criticism')
  artist_talent  = Theme.create( subject: :artists,
                                  name: 'Talent')
  artist_influence  = Theme.create( subject: :artists,
                                  name: 'Influence')
end
puts "Number of artist themes loaded: #{Theme.artists.count}"

lorem1 = "Crinis verus versus appositus voluptatem cena ambitus non. Tandem vomica cursus. Pariatur bis accusator vultuosus. Dolores reprehenderit trans defluo conor. Cursim attollo voluptatem thymbra solum tot tres. Vilicus decerno valens decimus cicuta. Vae cum molestiae bellicus aqua animi demergo. Aeternus aduro pax vergo odit crinis derideo."
lorem2 = "Stipes auris appositus vilicus cavus absconditus thema dedecor. Aperte spero curis depono sui. Atrox stipes comprehendo uredo sonitus arbitro clementia. Despecto bellicus cauda cursim conturbo. Fugiat chirographum aer sono benevolentia. Unde cohibeo in patria temeritas tero tenus. Tener vita dapifer tabula."
lorem3 = "Totidem fugiat ipsa assumenda deporto nulla accedo contra. Occaecati curiositas molestiae. Calco ut laudantium vae tandem acies deserunt acerbitas. Sint vapulus vitium defungo veritas. Voluptatem curso uredo error pecto ipsa. Vae truculenter ipsam expedita tabernus alii cicuta ultra. Bardus modi ars talus non inflammatio."
lorem4 = "Anser doloremque corona altus aegrus eos. Articulus careo est capillus claustrum depromo. Careo vereor verto tego acer. Depereo sit defessus venia validus. Solvo calcar apparatus inflammatio teneo contigo tardus copiose. Vester adaugeo consuasor. Ulciscor aut non volutabrum voluptatum tamisium. Qui ulciscor taedium quis angustus thesaurus colloco adsidue."
lorem5 = "Casso voluptates cunabula victoria adaugeo desidero tres. Astrum utpote tabgo soluta odit terminatio. Accipio omnis basium cometes. Tero tardus aer cilicium annus constans. Arbitro defluo addo ipsum armo quia sub. Vigor aperte cohaero illo sub tendo laudantium adeptio. Temeritas iste stipes viduata eum. Nihil claro confido dolores totus eius utroque antepono."
lorem6 = "Ultio advoco torqueo trucido aiunt triduana defetiscor. Ocer calamitas sponte at ipsum armo triginta aer. Patria uberrime cuius. Triginta degenero quae laboriosam speculum uredo. Architecto est amaritudo vetus. Vitiosus spargo iure corroboro voluptatem culpa adhuc quisquam. Ulterius carus bardus totus vinitor. Vulgivagus comprehendo terreo synagoga assentator. Sono vallum texo aegrus vulgo conventus ara deputo."

# Article.delete_all
# Create a few articles per instrument
Instrument.all.each do |ins|
  art1 = Article.create(title: "The early history of #{ins.name}", publishable: ins,
                          body: lorem1, author: user, theme: description)
  Approval.create(approvable: art1, approval_status: :incomplete, rejection_reason: :not_rejected)

  art2 = Article.create(title: "The meaning of #{ins.name}", publishable: ins,
                          body: lorem2, author: user, theme: etymology)
  Approval.create(approvable: art2, approval_status: :submitted, rejection_reason: :not_rejected)

  art3 = Article.create(title: "The construction of #{ins.name}", publishable: ins,
                          body: lorem3, author: user, theme: construction)
  Approval.create(approvable: art3, approval_status: :submitted, rejection_reason: :not_rejected, approver: approver)

  art4 = Article.create(title: "The history of #{ins.name}", publishable: ins,
                          body: lorem4, author: user, theme: history)
  Approval.create(approvable: art4, approval_status: :approved, rejection_reason: :not_rejected, approver: approver)

  art5 = Article.create(title: "The operation of #{ins.name}", publishable: ins,
                          body: lorem5, author: user, theme: operation)
  Approval.create(approvable: art5, approval_status: :approved, rejection_reason: :not_rejected, approver: approver)

  art6 = Article.create(title: "Techniques to play the #{ins.name}", publishable: ins,
                          body: lorem6, author: user, theme: technique)
  Approval.create(approvable: art6, approval_status: :to_be_revised, rejection_reason: :grammar_and_spelling, approver: approver)
end
instrument_article_count = Article.where("publishable_type = ?", 'Instrument').count
puts "Number of instrument articles loaded: #{instrument_article_count}"

puts "Number of approvals loaded: #{Approval.count}"

# Artist.delete_all
if Artist.count == 0
  artist1 = Artist.create(gender: :male, born_on: Date.new(1945,1,10), submitted_by: user,
    born_country_code: 'gb', artist_names_attributes: [ { name: 'Roderick', name_type: 0}, 
      { name: 'David', name_type: 1}, { name: 'Steward', name_type: 2}, { name: 'Rod Steward', name_type: 3}])
  Approval.create(approvable: artist1, approval_status: :submitted, rejection_reason: :not_rejected)

  artist2 = Artist.create(gender: :female, born_on: Date.new(1981,12,2), submitted_by: user,
    born_country_code: 'us', artist_names_attributes: [ { name: 'Britney', name_type: 0}, 
      { name: 'Jean', name_type: 1}, { name: 'Spears', name_type: 2}, { name: 'Britney Spears', name_type: 3}])
  Approval.create(approvable: artist2, approval_status: :submitted, rejection_reason: :not_rejected)

  artist3 = Artist.create(gender: :male, born_on: Date.new(1951,1,30), submitted_by: user,
    born_country_code: 'gb', artist_names_attributes: [ { name: 'Philip', name_type: 0}, 
      { name: 'David', name_type: 1}, { name: 'Charles', name_type: 1}, { name: 'Collins', name_type: 2}, { name: 'Phil Collins', name_type: 3}])
  Approval.create(approvable: artist3, approval_status: :submitted, rejection_reason: :not_rejected)

  artist4 = Artist.create(gender: :female, born_on: Date.new(1946,1,19), submitted_by: user,
    born_country_code: 'us', artist_names_attributes: [ { name: 'Dolly', name_type: 0}, 
      { name: 'Rebecca', name_type: 1}, { name: 'Parton', name_type: 2}, { name: 'Dolly Parton', name_type: 3}])
  Approval.create(approvable: artist4, approval_status: :submitted, rejection_reason: :not_rejected)

  artist5 = Artist.create(gender: :male, born_on: Date.new(1932,2,26), submitted_by: user,
    born_country_code: 'us', artist_names_attributes: [ { name: 'John', name_type: 0}, 
      { name: 'R', name_type: 1}, { name: 'Cash', name_type: 2}, { name: 'Johnny Cash', name_type: 3}])
  Approval.create(approvable: artist5, approval_status: :submitted, rejection_reason: :not_rejected)

  artist6 = Artist.create(gender: :male, born_on: Date.new(1941,10,13), submitted_by: user,
    born_country_code: 'us', artist_names_attributes: [ { name: 'Paul', name_type: 0}, 
      { name: 'Frederic', name_type: 1}, { name: 'Simon', name_type: 2}, { name: 'Paul Simon', name_type: 3}])
  Approval.create(approvable: artist6, approval_status: :submitted, rejection_reason: :not_rejected)

  artist7 = Artist.create(gender: :male, born_on: Date.new(1031,7,18), died_on: Date.new(1054, 9, 24), submitted_by: user,
    born_country_code: 'us', artist_names_attributes: [ { name: 'Hermann of Reichenau', name_type: 3}])
  Approval.create(approvable: artist7, approval_status: :submitted, rejection_reason: :not_rejected)

  artist8 = Artist.create(gender: :male, born_on: Date.new(1370,1,1), died_on: Date.new(1409, 12, 31), submitted_by: user,
    born_country_code: 'fr', artist_names_attributes: [ { name: 'Johannes Tapissier', name_type: 3}])
  Approval.create(approvable: artist8, approval_status: :submitted, rejection_reason: :not_rejected)

  artist9 = Artist.create(gender: :male, born_on: Date.new(1375,1,1), died_on: Date.new(1456, 10, 17), submitted_by: user,
    born_country_code: 'fr', artist_names_attributes: [ { name: 'Nicholas Grenon', name_type: 3}])
  Approval.create(approvable: artist9, approval_status: :submitted, rejection_reason: :not_rejected)

  artist10 = Artist.create(gender: :male, born_on: Date.new(1521,1,1), died_on: Date.new(1603, 7, 4), submitted_by: user,
    born_country_code: 'be', artist_names_attributes: [ { name: 'Philippe de Monte', name_type: 3}])
  Approval.create(approvable: artist10, approval_status: :submitted, rejection_reason: :not_rejected)

end

puts "Number of artists loaded: #{Artist.count}"
