class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.integer :category_id
      t.string :category_type

      t.timestamps
    end
  end
end
