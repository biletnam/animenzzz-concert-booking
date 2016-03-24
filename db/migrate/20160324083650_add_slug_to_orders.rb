class AddSlugToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :slug, :string
    add_index :orders, :slug, unique: true
  end
end
