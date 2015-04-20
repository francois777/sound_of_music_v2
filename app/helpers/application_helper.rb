module ApplicationHelper

  def options_for_instrument_rejection
    display_reasons = {}
    Instrument.rejection_reasons.each { |k,v| display_reasons[k.humanize] = v }
    display_reasons
  end

  def options_for_article_rejection
    display_reasons = {}
    Article.rejection_reasons.each { |k,v| display_reasons[k.humanize] = v }
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
