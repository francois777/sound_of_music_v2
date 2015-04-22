class RemoveArticleApprovalDetails < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.remove :rejection_reason
      t.remove :approval_status
      t.remove :approver_id
    end  
  end
end
