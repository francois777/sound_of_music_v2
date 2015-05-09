if HistoricalPeriod.count == 0
  HistoricalPeriod.create(
    name: 'Medieval Period',
    period_from: Date.new(1100,1,1),
    period_end:  Date.new(1400,1,1) - 1,
    overview: 'Medieval music is European music written during the middle ages. The era begins with the fall of the Roman Empire.'
    )
  HistoricalPeriod.create(
    name: 'Renaissance Period',
    period_from: Date.new(1400,1,1),
    period_end:  Date.new(1600,1,1) - 1,
    overview: 'Rennainsance music is European music written during the Renaissance.'
    )
  HistoricalPeriod.create(
    name: 'Baroque Period',
    period_from: Date.new(1600,1,1),
    period_end:  Date.new(1750,1,1) - 1,
    overview: 'Baroque music describes a style of European Classical music.'
    )
  HistoricalPeriod.create(
    name: 'Classical Period',
    period_from: Date.new(1750,1,1),
    period_end:  Date.new(1820,1,1) - 1,
    overview: 'The term Classical Period is used colloquilly to describe a variety of Western musical styles.'
    )
  HistoricalPeriod.create(
    name: 'Romantic Period',
    period_from: Date.new(1820,1,1),
    period_end:  Date.new(1900,1,1) - 1,
    overview: 'Romantic music is a term denoting an era of Western classical music that began in the late 18th or early 19th century. It was related to Romanticism, the European artistic and literary movement that arose in the second half of the 18th century, and Romantic music in particular dominated the Romantic movement in Germany.'
    )
  HistoricalPeriod.create(
    name: '20th and 21st Century',
    period_from: Date.new(1900,1,1),
    period_end: Date.new(2100,1,1) - 1,
    overview: '20th-century classical music was without a dominant style and highly diverse.'
    )

  puts "Number of historical periods loaded: #{HistoricalPeriod.count}"

end