class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :user, index: true
      t.references :barbecue, index: true
      t.timestamps null: false
    end
  end
end
