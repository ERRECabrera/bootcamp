class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :description
      t.references :product, index: true
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
