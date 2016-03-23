class AddSlugToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :slug, :string
    add_index :prices, :slug, unique: true
  end
end
