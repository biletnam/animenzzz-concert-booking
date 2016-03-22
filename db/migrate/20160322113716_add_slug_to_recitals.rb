class AddSlugToRecitals < ActiveRecord::Migration
  def change
    add_column :recitals, :slug, :string
    add_index :recitals, :slug, unique: true
  end
end
