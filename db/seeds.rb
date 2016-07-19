# Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

user_seeds = File.join(Rails.root, 'db', 'seeds', '01_users.rb')
category_seeds = File.join(Rails.root, 'db', 'seeds', '02_instrument_categories.rb')
instrument_seeds = File.join(Rails.root, 'db', 'seeds', '03_instruments.rb')
theme_seeds = File.join(Rails.root, 'db', 'seeds', '04_themes.rb')
instrument_article_seeds = File.join(Rails.root, 'db', 'seeds', '05_instrument_articles.rb')
artist_seeds = File.join(Rails.root, 'db', 'seeds', '06_artists.rb')
historical_period_seeds = File.join(Rails.root, 'db', 'seeds', '07_historical_periods.rb')
contribution_type_seeds = File.join(Rails.root, 'db', 'seeds', '08_contribution_types.rb')

load user_seeds
load category_seeds
load instrument_seeds
load theme_seeds
load instrument_article_seeds
load artist_seeds
load historical_period_seeds
load contribution_type_seeds