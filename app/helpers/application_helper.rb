module ApplicationHelper

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

end
