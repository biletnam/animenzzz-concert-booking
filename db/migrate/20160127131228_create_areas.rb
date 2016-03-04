class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer :price
      t.integer :capacity
      t.references :recital, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
