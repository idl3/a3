class RemoveAddnewFromBusinesses < ActiveRecord::Migration
  def up
    remove_column :businesses, :addnew
      end

  def down
    add_column :businesses, :addnew, :integer
  end
end
