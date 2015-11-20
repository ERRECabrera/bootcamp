class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :band
      t.text :venue
      t.string :city
      t.datetime :date
      t.integer :price
      t.text :description
      t.timestamps null: false
    end
  end
end
