# Create instrument themes
if Theme.instruments.count == 0
  ["Characteristics", "Construction", "Description", "Etymology", "History", 
    "Operation", "Range", "Relevance today", "Technique"].each do |theme_name|

    Theme.create( subject: :instrument, name: theme_name)
  end

  puts "Number of instrument themes loaded: #{Theme.instruments.count}"
end

# Create artist themes
if Theme.artists.count == 0
  ["Biography", "Overview", "Achievements", "Character", "Legacy", 
    "Musical style", "Influences", "Career", "Recognition and Criticism", 
    "Talent", "Influence"].each do |theme_name|

    Theme.create( subject: :artist, name: theme_name)
  end  

  puts "Number of artist themes loaded: #{Theme.artists.count}"
end