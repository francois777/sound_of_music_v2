if Article.all_for_publishable_type('Instrument').count == 0
  lorem1 = "Crinis verus versus appositus voluptatem cena ambitus non. Tandem vomica cursus. Pariatur bis accusator vultuosus. Dolores reprehenderit trans defluo conor. Cursim attollo voluptatem thymbra solum tot tres. Vilicus decerno valens decimus cicuta. Vae cum molestiae bellicus aqua animi demergo. Aeternus aduro pax vergo odit crinis derideo."
  lorem2 = "Stipes auris appositus vilicus cavus absconditus thema dedecor. Aperte spero curis depono sui. Atrox stipes comprehendo uredo sonitus arbitro clementia. Despecto bellicus cauda cursim conturbo. Fugiat chirographum aer sono benevolentia. Unde cohibeo in patria temeritas tero tenus. Tener vita dapifer tabula."
  lorem3 = "Totidem fugiat ipsa assumenda deporto nulla accedo contra. Occaecati curiositas molestiae. Calco ut laudantium vae tandem acies deserunt acerbitas. Sint vapulus vitium defungo veritas. Voluptatem curso uredo error pecto ipsa. Vae truculenter ipsam expedita tabernus alii cicuta ultra. Bardus modi ars talus non inflammatio."
  lorem4 = "Anser doloremque corona altus aegrus eos. Articulus careo est capillus claustrum depromo. Careo vereor verto tego acer. Depereo sit defessus venia validus. Solvo calcar apparatus inflammatio teneo contigo tardus copiose. Vester adaugeo consuasor. Ulciscor aut non volutabrum voluptatum tamisium. Qui ulciscor taedium quis angustus thesaurus colloco adsidue."
  lorem5 = "Casso voluptates cunabula victoria adaugeo desidero tres. Astrum utpote tabgo soluta odit terminatio. Accipio omnis basium cometes. Tero tardus aer cilicium annus constans. Arbitro defluo addo ipsum armo quia sub. Vigor aperte cohaero illo sub tendo laudantium adeptio. Temeritas iste stipes viduata eum. Nihil claro confido dolores totus eius utroque antepono."
  lorem6 = "Ultio advoco torqueo trucido aiunt triduana defetiscor. Ocer calamitas sponte at ipsum armo triginta aer. Patria uberrime cuius. Triginta degenero quae laboriosam speculum uredo. Architecto est amaritudo vetus. Vitiosus spargo iure corroboro voluptatem culpa adhuc quisquam. Ulterius carus bardus totus vinitor. Vulgivagus comprehendo terreo synagoga assentator. Sono vallum texo aegrus vulgo conventus ara deputo."

  characteristics = Theme.where("name = ?", 'Characteristics').first
  construction = Theme.where("name = ?", 'Construction').first
  description = Theme.where("name = ?", 'Description').first
  etymology = Theme.where("name = ?", 'Etymology').first
  history = Theme.where("name = ?", 'History').first
  operation = Theme.where("name = ?", 'Operation').first
  range = Theme.where("name = ?", 'Range').first
  relevance = Theme.where("name = ?", 'Relevance').first
  technique = Theme.where("name = ?", 'Technique').first

  user = User.where('last_name = ?', 'User').first

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

    instrument_article_count = Article.where("publishable_type = ?", 'Instrument').count
    puts "Number of instrument articles loaded: #{instrument_article_count}"
    puts "Number of approvals loaded: #{Approval.count}"
  end
end