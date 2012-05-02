class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.integer :business_id
      t.text :press
      t.text :videos
      t.text :photos

      t.timestamps
    end
  end
end
