class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.datetime :born_on
      t.datetime :died_on
      t.string  :assigned_name, null: false
      t.string  :born_country_code,    default: ""
      t.integer :historical_period_id, default: 0
      t.integer :gender,               default: 0
      t.references :submitted_by, null: false   
      t.timestamps null: false
    end

    create_table :artist_names do |t|
      t.integer :artist_id
      t.string :name
      t.integer :name_type
    end 
    add_index :artist_names, :name

    create_table :approvals do |t|
      t.integer :approval_status,  default: 0
      t.integer :rejection_reason, default: 0
      t.references :approvable, polymorphic: true
      t.references :approver,   default: 0
      t.timestamps null: false
    end
    add_index :approvals, [:approvable_id, :approvable_type]

  end
end
