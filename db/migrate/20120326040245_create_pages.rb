class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.text :body
      t.boolean :published
      t.integer :status

      t.timestamps
    end
  end
end
