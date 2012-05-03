class ChangeMissionInBusinesses < ActiveRecord::Migration
  def up
    change_column :businesses, :mission, :text
  end

  def down
    change_column :businesses, :mission, :string
  end
end
