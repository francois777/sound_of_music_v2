module ApplicationHelper

  def options_for_instrument_rejection
    display_reasons = {}
    Instrument.rejection_reasons.each { |k,v| display_reasons[k.humanize] = v }
    display_reasons
  end

end
