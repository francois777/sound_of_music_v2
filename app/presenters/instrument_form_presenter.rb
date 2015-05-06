class InstrumentFormPresenter
  include ApplicationHelper

  attr_reader :instrument, :articles

  def initialize(instrument, articles)
    @instrument, @articles = instrument, articles
  end

  def name
    @instrument.name
  end

  def category_name
    @instrument.category.name
  end

  def subcategory_name
    @instrument.subcategory ? " / #{@instrument.subcategory.name}" : ""
  end

  def origin_period
    @instrument.origin_period.present? ? @instrument.origin_period : "Unknown"
  end

  def created_by_name
    @instrument.created_by.name
  end

  def no_articles_message
    "No articles have been written for this instrument. Please write the first one!"
  end

end