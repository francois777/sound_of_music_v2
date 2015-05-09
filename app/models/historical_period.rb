class HistoricalPeriod < ActiveRecord::Base

  has_many :artists
  validates :name, :period_from, :period_end, :overview, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, length: { minimum: 5, maximum: 30 }
  validate :start_before_end
  validate :overlapping_periods

  default_scope -> { order('period_from ASC') }

  scope :medieval, -> {
    where("name = ?", "Medieval Period").first
  }
  scope :renaissance, -> {
    where("name = ?", "Renaissance Period").first
  }
  scope :baroque, -> {
    where("name = ?", "Baroque Period").first
  }
  scope :classical, -> { 
    where("name = ?", 'Classical Period').first
  }
  scope :romantic, -> {
    where("name = ?", 'Romantic Period').first
  }

  def self.find_historical_period_by_name(name)
    period = HistoricalPeriod.where("name LIKE ?", "#{name}%").first
  end

  private

    def start_before_end
      errors.add(:period_end, 'Invalid period end') if period_from > period_end
    end

    def overlapping_periods
      period = HistoricalPeriod.all.select { |prd| (self.period_from <= prd.period_end) and (self.period_end >= prd.period_from) and (self.id != prd.id) }
      errors.add(:from, 'Overlapping period') unless period.empty?
    end

end