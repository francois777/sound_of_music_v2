class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.string :image_name
      t.references :submitted_by, default: 0
      t.references :approved_by,  default: 0
      t.references :imageable, polymorphic: true
      t.integer :approval_status, default: 0
      t.integer :rejection_reason, default: 0
      t.string :image
      t.integer :bytes
      t.integer :width
      t.integer :height
      t.string  :format
      t.timestamps null: false
    end
    add_index :photos, [:imageable_id, :imageable_type]
    add_index :photos, :submitted_by_id, name: 'index_photo_submitted_by'
    add_index :photos, :approved_by_id, name: 'index_photo_approved_by'
  end
end
