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
    Photo.rejection_reasons.each { |k,v| display_reasons[k.humanize] = v }
    display_reasons
  end

end
