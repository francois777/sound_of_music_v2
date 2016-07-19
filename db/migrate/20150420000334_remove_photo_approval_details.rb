class RemovePhotoApprovalDetails < ActiveRecord::Migration
  def self.up
    change_table :photos do |t|
      t.remove_index :photos, :approved_by_id if index_exists?(:photos, :approved_by_id)
      t.remove :approved_by_id
      t.remove :approval_status
      t.remove :rejection_reason
    end  
  end

  def self.down
    add_column :photos, :approved_by_id, :integer
    add_column :photos, :approval_status, :integer
    add_column :photos, :rejection_reason, :integer
    add_index :photos, :approved_by_id, name: 'index_photo_approved_by'
  end
end
