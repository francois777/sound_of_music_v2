class AddNameToContributionTypes < ActiveRecord::Migration
  def change
    add_column :contribution_types, :name, :string

    add_index :contribution_types, :name, name: 'index_contribution_type_by_name'
  end
end
