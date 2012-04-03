class AddApprovedToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :approved, :boolean

  end
end
