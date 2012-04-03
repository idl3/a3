class AddAddnewToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :addnew, :integer

  end
end
