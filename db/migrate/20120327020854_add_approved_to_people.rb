class AddApprovedToPeople < ActiveRecord::Migration
  def change
    add_column :people, :approved, :boolean

  end
end
