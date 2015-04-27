class CreateHistoricalPeriods < ActiveRecord::Migration
  def change
    create_table :historical_periods do |t|
      t.string :name
      t.date   :period_from
      t.date   :period_end
      t.text   :overview
    end
  end
end
