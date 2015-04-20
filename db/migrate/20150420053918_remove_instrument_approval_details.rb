class RemoveInstrumentApprovalDetails < ActiveRecord::Migration
  def change
    change_table :instruments do |t|
      t.remove :rejection_reason
      t.remove :approval_status
      t.remove :approver_id
    end  
  end
end
