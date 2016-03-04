class CreateOrderitems < ActiveRecord::Migration
  def change
    create_table :orderitems do |t|
      t.references :order, index: true, foreign_key: true
      t.references :seat, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
