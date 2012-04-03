class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.string :title
      t.text :body
      t.boolean :published
      t.integer :status
      t.string :tags
      t.integer :author
      t.integer :moderator

      t.timestamps
    end
  end
end
