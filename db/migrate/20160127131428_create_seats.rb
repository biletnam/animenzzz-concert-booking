class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.integer :locate_x
      t.integer :locate_y
      t.boolean :sold, default: false
      t.references :area, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
