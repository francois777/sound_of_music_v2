if Instrument.count == 0

  user = User.where('last_name = ?', 'User').first

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

  puts "Number of instruments loaded: #{Instrument.count}"
end

