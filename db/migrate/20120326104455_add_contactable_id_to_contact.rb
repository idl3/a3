class AddContactableIdToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :contactable_id, :integer

  end
end
