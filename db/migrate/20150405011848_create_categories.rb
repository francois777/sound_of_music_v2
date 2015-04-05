class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
    end

    create_table :subcategories do |t|
      t.string :name
      t.references :category
    end
  end
end
