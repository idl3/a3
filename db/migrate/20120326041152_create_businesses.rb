class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :regno
      t.integer :biztype
      t.integer :industrypri
      t.integer :industrysec
      t.string :country
      t.string :address
      t.integer :founded
      t.string :shareholding
      t.string :mission
      t.string :founders
      t.integer :staffno
      t.string :keystaff
      t.string :investors
      t.string :advisors
      t.text :uvp
      t.text :revenuemodel
      t.text :target
      t.string :competitors
      t.string :nutshell

      t.timestamps
    end
  end
end
