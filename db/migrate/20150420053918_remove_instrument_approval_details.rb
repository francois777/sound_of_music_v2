class RemoveInstrumentApprovalDetails < ActiveRecord::Migration
  def self.up
    remove_index :instruments, :approver_id if index_exists?(:instruments, :approver_id)

    remove_column :instruments, :rejection_reason
    remove_column :instruments, :approval_status
    remove_column :instruments, :approver_id
  end

  def self.down
    add_column :instruments, :rejection_reason, :integer unless Instrument.column_names.include?('rejection_reason')
    add_column :instruments, :approval_status, :integer  unless Instrument.column_names.include?('approval_status')
    add_column :instruments, :approver_id, :integer      unless Instrument.column_names.include?('approver_id')
  end
end

