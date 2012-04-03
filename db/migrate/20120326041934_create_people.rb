class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.date :birthdate
      t.string :designation
      t.string :company
      t.string :skills
      t.text :background
      t.text :portfolio

      t.timestamps
    end
  end
end
