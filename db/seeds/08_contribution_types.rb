if ContributionType.count == 0

  definitions = {
    arranger: "In music, an arrangement is a musical reconceptualization of a previously composed work. It may differ from the original work by means of reharmonization, melodic paraphrasing, orchestration, or development of the formal structure. Arranging differs from orchestration in that the latter process is limited to the assignment of notes to instruments for performance by an orchestra, concert band, or other musical ensemble. Arranging 'involves adding compositional techniques, such as new thematic material for introductions, transitions, or modulations, and endings. Arranging is the art of giving an existing melody musical variety'.",
    band_leader: "A bandleader is the leader of a band of musicians. The term is most commonly, though not exclusively, used with a group that plays popular music as a small combo or a big band, such as one which plays jazz, blues, rhythm and blues or rock and roll music. \n Most bandleaders are also performers with their own band. The bandleader role is dependent on a variety of skills, not just musicianship. A bandleader needs to be a music director and performer. Often the bands are named after their bandleaders. Some older bands have continued operating under their bandleaders' names long after the death of the original bandleader.",
    composer: "A composer (Latin com+ponere, literally 'one who puts together') is a person who creates music. The core meaning of the term refers to individuals who have contributed to the tradition of Western classical music through creation of works expressed in written musical notation. In broader usage, 'composer' can designate people who participate in other musical traditions, as well as those who create music by means other than written notation; for example, through improvisation, recording, and arrangement.",
    conductor: "Conducting is the art of directing a musical performance by way of visible gestures. The primary duties of the conductor are to unify performers, set the tempo, execute clear preparations and beats, and to listen critically and shape the sound of the ensemble. \n Conductors act as guides to the orchestras and/or choirs they conduct. They choose the works to be performed and study their scores to which they may make certain adjustments, work out their interpretation, and relay their ideas to the performers. They may also attend to organizational matters, such as scheduling rehearsals. Orchestras, choirs, concert bands and other sizable musical ensembles are usually led by conductors.",
    a_capella: "A cappella (Italian for 'in the manner of the church' or 'in the manner of the chapel') music is specifically group or solo singing without instrumental accompaniment, or a piece intended to be performed in this way. It contrasts with cantata, which is accompanied singing. A cappella was originally intended to differentiate between Renaissance polyphony and Baroque concertato style. In the 19th century a renewed interest in Renaissance polyphony coupled with an ignorance of the fact that vocal parts were often doubled by instrumentalists led to the term coming to mean unaccompanied vocal music.",
    band: "A band, or musical ensemble, is a group of people who perform instrumental or vocal music, typically known by a distinct name. In classical music, trios or quartets either blend the sounds of musical instrument families (such as piano, strings, and wind instruments) or group together instruments from the same instrument family, such as string ensembles or wind ensembles. In jazz ensembles, the instruments typically include wind instruments (one or more saxophones, trumpets, etc.), one or two chordal 'comping' instruments (electric guitar, piano, or organ), a bass instrument (bass guitar or double bass), and a drummer or percussionist. In rock ensembles, usually called rock bands, there are usually guitars and keyboards (piano, electric piano, Hammond organ, synthesizer, etc.) and a rhythm section made up of a bass guitar and drum kit.",
    choir: "A choir (/ˈkwaɪ.ər/) (also known as a chorale or chorus) is a musical ensemble of singers. Choral music, in turn, is the music written specifically for such an ensemble to perform. \n A body of singers who perform together as a group is called a choir or chorus. The former term is very often applied to groups affiliated with a church (whether or not they actually occupy the choir) and the second to groups that perform in theatres or concert halls, but this distinction is far from rigid. \n The term 'Choir' has the secondary definition of a subset of an ensemble; thus one speaks of the 'woodwind choir' of an orchestra, or different 'choirs' of voices and/or instruments in a polychoral composition. In typical 18th- to 21st-century oratorios and masses, chorus or choir is usually understood to imply more than one singer per part, in contrast to the quartet of soloists also featured in these works.",
    instrumental_group: "This refers to a combination of musical instruments, producing a unique combined effect. This may also be a band, used for accompaniment only.",
    orchestra: "An orchestra is a large instrumental ensemble that contains sections of string, brass, woodwind, and percussion instruments. Other instruments such as the piano and celesta may sometimes be grouped into a fifth section such as a keyboard section or may stand alone, as may the concert harp and electric and electronic instruments. The term orchestra derives from the Greek ὀρχήστρα, the name for the area in front of an ancient Greek stage reserved for the Greek chorus. The orchestra grew by accretion throughout the 18th and 19th centuries, but changed very little in composition during the course of the 20th century.",
    vocal_group: "Two or more vocalists where each artist has a special vocal contribution.",
    librettist: "The librettist is the person who writes a libretto. A libretto is the text used in, or intended for, an extended musical work such as an opera, operetta, masque, oratorio, cantata or musical. The term, libretto is also sometimes used to refer to the text of major liturgical works, such as the Mass, requiem and sacred cantata, or the story line of a ballet. \n Libretto (pl. libretti), from Italian, is the diminutive of the word libro (book). A libretto is distinct from a synopsis or scenario of the plot, in that the libretto contains all the words and stage directions, while a synopsis summarizes the plot. Some ballet historians also use the word libretto to refer to the 15–40 page books which were on sale to 19th century ballet audiences in Paris and contained a very detailed description of the ballet's story, scene by scene. \n The relationship of the librettist (that is, the writer of a libretto) to the composer in the creation of a musical work has varied over the centuries, as have the sources and the writing techniques employed.",
    lyricist: "A lyricist is a musician who specializes in writing lyrics. A singer who writes the lyrics to songs is a singer-lyricist. This differentiates from a singer-composer, who composes the song's melody.",
    playwright: "A playwright, also known as a dramatist, is a person who writes dramatic literature or drama. These works may be written specifically to be performed by actors, or they may be closet dramas - simple literary works - written using dramatic forms, but not meant for performance.",
    poet: "A poet is a person who writes poetry. Poets may describe themselves as such or be described as poets by others. A poet may simply be a writer of poetry, or may perform their art to an audience. \n Postmortal fictional portrait of Slovak poet Janko Kráľ (1822-1876) - an idealized romanticized picture of 'how a real poet should look like' in Western culture. \n The work of a poet is essentially one of communication, either expressing ideas in a literal sense, such as writing about a specific event or place, or metaphorically. Poets have existed since antiquity, in nearly all languages, and have produced works that vary greatly in different cultures and time periods. Throughout each civilization and language, poets have used various styles that have changed through the course of literary history, resulting in a history of poets as diverse as the literature they have produced.",
    screenwriter: "A screenplay writer, screenwriter for short, or scriptwriter or scenarist is a writer who practices the craft of screenwriting, writing screenplays on which mass media such as films, television programs, comics or video games are based. \n Screenwriting is a freelance profession. No education is required to become a professional screenwriter, just good storytelling abilities and imagination. Screenwriters are not hired employees, they are contracted freelancers. Most, if not all, screenwriters start their careers writing on speculation (spec), meaning they write without being hired or paid for it. If such a script is sold, it is called a spec script. What separates a professional screenwriter from an amateur screenwriter is that professional screenwriters are usually represented by a talent agency. Also, professional screenwriters do not often work for free; whereas amateur screenwriters will often work for free and are considered 'writers in training'. Spec scripts are usually penned by unknown professional screenwriters and amateur screenwriters. There are a legion of would-be screenwriters who attempt to enter the film industry but it often takes years of trial-and-error, failure, and gritty persistence to achieve success. In Writing Screenplays that Sell, Michael Hague writes 'Screenplays have become, for the last half of [the twentieth] century, what the Great American Novel was for the first half. Closet writers who used to dream of the glory of getting into print now dream of seeing their story on the big or small screen.'",
    songwriter: "A songwriter is an individual who writes songs and can also be called a composer. The pressure to produce popular hits has tended to distribute responsibility between a number of people. Popular culture songs may be written by group members or by staff writers: songwriters directly employed by music publishers. \n Some songwriters serve as their own music publishers, while others have outside publishers. Furthermore, songwriters no longer need labels to support their music. Technology has advanced to the point where anyone can record at home. \n The old-style apprenticeship approach to learning how to write songs is being supplemented by some universities and colleges and rock schools. A knowledge of modern music technology, songwriting elements, and business skills are seen as necessary requirements to make a songwriting career. Several music colleges offer songwriting diplomas and degrees with music business modules. \n Since songwriting and publishing royalties can be a substantial source of income, particularly if a song becomes a hit record, legally, in the US, songs written after 1934 may only be copied by the authors. The legal power to grant these permissions may be bought, sold or transferred. This is governed by international copyright law. \n Professional songwriters can either be employed to write either the lyrics or the music directly for or alongside a performing artist, or they present songs to A&R, publishers, agents and managers for consideration. Song pitching can be done on a songwriter's behalf by their publisher or independently using tip sheets like RowFax, the MusicRow publication, and SongQuarters. Skills associated with song-writing include entrepreneurism and creativity."
  }

  ContributionType.create(
      classification: :arranger,
      group_type: :individual,
      voice_type: :not_applicable,
      definition: definitions[:arranger]
    )
  ContributionType.create(
      classification: :band_leader,
      group_type: :individual,
      voice_type: :not_applicable,
      definition: definitions[:bandleader]
    )
  ContributionType.create(
      classification: :composer,
      group_type: :individual,
      voice_type: :not_applicable,
      definition: definitions[:composer]
    )
  ContributionType.create(
      classification: :conductor,
      group_type: :individual,
      voice_type: :not_applicable,
      definition: definitions[:conductor]
    )
  ContributionType.create(
      classification: :group_of_musicians,
      group_type: :a_capella_choir,
      voice_type: :not_applicable,
      definition: definitions[:a_capella]
    )
  ContributionType.create(
      classification: :group_of_musicians,
      group_type: :band,
      voice_type: :not_applicable,
      definition: definitions[:band]
    )
  ContributionType.create(
      classification: :group_of_musicians,
      group_type: :choir,
      voice_type: :not_applicable,
      definition: definitions[:choir]
    )
  ContributionType.create(
      classification: :group_of_musicians,
      group_type: :instrumental_group,
      voice_type: :not_applicable,
      definition: definitions[:instrumental_group]
    )
  ContributionType.create(
      classification: :group_of_musicians,
      group_type: :orchestra,
      voice_type: :not_applicable,
      definition: definitions[:orchestra]
    )
  ContributionType.create(
      classification: :group_of_musicians,
      group_type: :vocal_group,
      voice_type: :not_applicable,
      definition: definitions[:vocal_group]
    )
  ContributionType.create(
      classification: :librettist,
      group_type: :individual,
      voice_type: :not_applicable,
      definition: definitions[:librettist]
    )
  ContributionType.create(
      classification: :lyricist,
      group_type: :individual,
      voice_type: :not_applicable,
      definition: definitions[:lyricist]
    )
  ContributionType.create(
      classification: :playwright,
      group_type: :individual,
      voice_type: :not_applicable,
      definition: definitions[:playwright]
    )
  ContributionType.create(
      classification: :poet,
      group_type: :individual,
      voice_type: :not_applicable,
      definition: definitions[:poet]
    )
  ContributionType.create(
      classification: :screenwriter,
      group_type: :individual,
      voice_type: :not_applicable,
      definition: definitions[:screenwriter]
    )
  ContributionType.create(
      classification: :songwriter,
      group_type: :individual,
      voice_type: :not_applicable,
      definition: definitions[:songwriter]
    )

  puts "Number of contribution types loaded: #{ContributionType.count}"

end
