class CreateInstruments < ActiveRecord::Migration
  def change
    create_table :instruments do |t|
      t.string :name
      t.integer :category, default: 0
      t.integer :subcategory, default: 0
      t.boolean :tuned, default: false
      t.string :other_names, default: ""
      t.string :performer_title, default: ""
      t.string :origin_period, default: ""
      t.integer :created_by_id,             null: false
      t.integer :last_image_id, default: 0
      t.integer :approval_status, default: 0
      t.integer :rejection_reason, default: 0

      t.timestamps null: false
    end
  end
end
