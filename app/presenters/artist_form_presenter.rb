class ArtistFormPresenter
  include ApplicationHelper

  attr_reader :artist, :articles

  def initialize(artist, articles)
    @artist, @articles = artist, articles
  end

  def options_for_artist_name_types(name)
    options_for_select(ArtistName.name_types.collect { |nt| [nt[0].humanize, nt[1]] }, 
      selected: ArtistName.name_types[name.object.name_type.to_s.to_sym]
    )
  end

  def name
    @artist.assigned_name
  end

  def birth_names
    @artist.name_profile.birth_names
  end

  def gender
    @artist.gender.titleize
  end

  def born_on
    display_date(@artist.born_on)
  end

  def died_on
    if @artist.died_on.present?
      display_date(@artist.died_on)
    else
      "still alive!"
    end
  end

  def country_of_birth
    I18n.t("countries.#{@artist.born_country_code}")
  end

  def historical_period_name
    @artist.historical_period.name
  end

  def submitted_by_name
    @artist.submitted_by.name
  end

  def no_articles_message
    "No articles have been written on #{@artist.name}. Please write the first one!"
  end

end