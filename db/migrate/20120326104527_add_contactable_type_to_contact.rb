class AddContactableTypeToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :contactable_type, :string

  end
end
