class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :instruments, :category, :category_id
    rename_column :instruments, :subcategory, :subcategory_id
  end
end
