class AddCategoryTypeToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :category_type, :string

  end
end
