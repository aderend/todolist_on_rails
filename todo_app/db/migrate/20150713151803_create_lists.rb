class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :category, null: false
      t.string :created_by, null: false
      t.timestamps null: false
    end
  end
end
