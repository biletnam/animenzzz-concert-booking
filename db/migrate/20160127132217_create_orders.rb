class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :pay_time
      t.datetime :apply_time
      t.datetime :refund_time
      t.integer  :price
      t.string   :address
      t.string   :trac_num
      t.string   :express
      t.string   :name
      t.string   :phone
      t.integer  :status
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
