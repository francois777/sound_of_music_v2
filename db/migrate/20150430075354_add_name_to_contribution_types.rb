class AddNameToContributionTypes < ActiveRecord::Migration
  def self.up
    add_column :contribution_types, :name, :string

    add_index :contribution_types, :name, name: 'index_contribution_type_by_name'
  end

  def self.down
    remove_index :contribution_types, :name if index_exists?(:contribution_types, :name)

    remove_column :contribution_types, :name if column_exists?(:contribution_types, :name)
  end
end
