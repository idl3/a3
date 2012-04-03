class AddApproverToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :approver, :integer

  end
end
