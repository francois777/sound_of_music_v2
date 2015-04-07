class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.references :publishable, polymorphic: true
      t.references :author,   null: false
      t.references :theme,    null: false
      t.integer :approval_status,  default: 0
      t.integer :rejection_reason, default: 0
      t.text :body
      t.timestamps null: false
    end
    add_index :articles, [:publishable_id, :publishable_type]
    add_index :articles, :author_id, name: 'index_article_author'

    create_table :themes do |t|
      t.integer :subject
      t.string :name
    end
  end
end
