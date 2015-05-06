module ApplicationHelper

  # def present(model, presenter_class)
  #   klass = presenter_class
  #   presenter = klass.new(model, self)
  #   yield(presenter) if block_given?
  # end

  def options_for_instrument_rejection
    display_reasons = {}
    Instrument::REJECTION_REASONS.each_with_index { |k,inx| display_reasons[k.to_s.humanize] = inx }
    display_reasons
  end

  def options_for_article_rejection
    display_reasons = {}
    Article::REJECTION_REASONS.each_with_index { |k,inx| display_reasons[k.to_s.humanize] = inx }
    display_reasons
  end

  def options_for_photo_rejection
    display_reasons = {}
    Photo::REJECTION_REASONS.each_with_index { |k,inx| display_reasons[k.to_s.humanize] = inx }
    display_reasons
  end

  def options_for_artist_rejection
    display_reasons = {}
    Artist::REJECTION_REASONS.each_with_index { |k,inx| display_reasons[k.to_s.humanize] = inx }
    display_reasons
  end

  def options_for_rejection(resource)
    case resource.class.name
    when "Instrument"
      options_for_instrument_rejection
    when "Photo"
      options_for_photo_rejection
    when "Article"
      options_for_article_rejection
    when "Artist"
      options_for_artist_rejection
    end
  end

  def deceased_date(date, options = {})
    date.nil? ? 'Still alive!' : display_date(date, options)
  end

  def display_date(date, options = {})
    return "" if date == nil
    return date.strftime("%d %B %Y") unless options[:format]
    case options[:format]
      when :short
        date.strftime("%d/%m/%Y")
      when :month  
        date.strftime("%B %Y")
    end
  end

  def historical_period_for(artist)
    period = artist.historical_period
    return 0 unless HistoricalPeriod.any?
    period ? period.id : HistoricalPeriod.first.id
  end

  def publishable_themes(class_name)
    if class_name == 'Instrument'
      Theme.instruments
    elsif class_name == 'Artist'
      Theme.artists
    end
  end

  def subcategories_for_category(category_id)
    Subcategory.where("category_id = ?", category_id)  
  end
end