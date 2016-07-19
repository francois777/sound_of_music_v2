class RemoveArticleApprovalDetails < ActiveRecord::Migration
  def self.up
    remove_index :articles, :approver_id if index_exists?(:articles, :approver_id)

    remove_column :articles, :rejection_reason if column_exists?(:articles, :rejection_reason)
    remove_column :articles, :approval_status if column_exists?(:articles, :approval_status)
    remove_column :articles, :approver_id if column_exists?(:articles, :approval_status)
  end

  def self.down
    add_column :articles, :approval_status, :integer, default: 0 unless column_exists?(:articles, :approval_status)
    add_column :articles, :rejection_reason, :integer, default: 0 unless column_exists?(:articles, :rejection_reason)
    add_column :articles, :approver_id, :integer, default: 0 unless column_exists?(:articles, :approver_id)

    # add_index  :articles, :approver_id, name: 'index_article_approver' unless index_exists?(:articles, :approver_id)
  end
end

