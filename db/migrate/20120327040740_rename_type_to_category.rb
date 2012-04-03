class RenameTypeToCategory < ActiveRecord::Migration
  def change
    rename_column :attachments, :type, :category
  end
end
