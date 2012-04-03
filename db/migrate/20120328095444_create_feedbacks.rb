class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
