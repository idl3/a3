class RenameLinkedinidToSecurityStringInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :linkedinid, :security_string
  end

  def down
    rename_column :users, :security_string, :linkedinid
  end
end
