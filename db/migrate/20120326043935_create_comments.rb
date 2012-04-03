class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :body
      t.integer :parent_post
      t.integer :parent_comment
      t.boolean :toplevel
      t.integer :user_id

      t.timestamps
    end
  end
end
