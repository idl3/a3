class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.string :name
      t.string :type
      t.integer :user_id
      t.text :data
      t.boolean :approved
      t.integer :approved_by

      t.timestamps
    end
  end
end
