class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :product_id
      t.integer :cart_id
      t.integer :quantity_ordered

      t.timestamps
    end
  end
end
