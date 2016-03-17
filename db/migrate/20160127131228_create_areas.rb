class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string  :name
      t.string  :klass
      t.integer :capacity
      t.integer :floor
      t.references :recital, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
