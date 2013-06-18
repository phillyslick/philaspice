class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :cart
      t.references :order
      t.references :price
      t.integer :quantity
      t.string :name
      t.decimal :cost, precision: 9, scale: 2
      t.integer :ounces

      t.timestamps
    end
    add_index :line_items, :cart_id
    add_index :line_items, :order_id
    add_index :line_items, :price_id
  end
end
