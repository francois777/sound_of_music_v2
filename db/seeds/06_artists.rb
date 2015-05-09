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

  puts "Number of artists loaded: #{Artist.count}"

end
