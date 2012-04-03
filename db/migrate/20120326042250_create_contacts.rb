class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :website
      t.string :blog
      t.string :twitter
      t.string :facebook
      t.string :linkedin
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
