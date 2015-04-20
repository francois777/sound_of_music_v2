class RemovePhotoApprovalDetails < ActiveRecord::Migration
  def change
    change_table :photos do |t|
      t.remove :approved_by_id
      t.remove :approval_status
      t.remove :rejection_reason
    end  
  end
end
