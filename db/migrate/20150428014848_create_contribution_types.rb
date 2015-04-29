class CreateContributionTypes < ActiveRecord::Migration
  def change
    create_table :contribution_types do |t|
      t.text :definition
      t.integer :classification, default: 11
      t.integer :group_type, default: 0
      t.integer :voice_type, default: 1
    end

    create_table :artist_contribution do |t|
      t.references :artist,            null: false
      t.references :contribution_type, null: false
      t.text :comment
      t.timestamps null: false
    end
    add_index :artist_contribution, :artist_id, name: 'index_contribution_by_artist_id'
    add_index :artist_contribution, [:artist_id, :contribution_type_id], name: 'index_artist_contribution_pk'

    add_column :artists, :person_or_group, :integer, default: 0
  end
end
