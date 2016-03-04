class CreateRecitals < ActiveRecord::Migration
  def change
    create_table :recitals do |t|
      t.string :name
      t.string :city
      t.string :musician
      t.integer :capacity
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
