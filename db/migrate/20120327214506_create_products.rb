class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :unit_price
      t.integer :quantity_on_hand

      t.timestamps
    end
  end
end
