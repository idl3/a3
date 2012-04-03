class AddLinkedinidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :linkedinid, :string

  end
end
