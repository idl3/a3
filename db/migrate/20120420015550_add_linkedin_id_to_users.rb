class AddLinkedinIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_id, :integer

  end
end
