class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
    add_index :pictures, :name, unique: true
    add_index :pictures, :slug, unique: true
  end
end
