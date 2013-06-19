class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :total_price, precision: 9, scale: 2
      t.integer :total_weight
      t.decimal :shipping_cost, precision: 9, scale: 2
      t.references :customer
      t.datetime :archived_at

      t.timestamps
    end
    add_index :orders, :customer_id
  end
end
