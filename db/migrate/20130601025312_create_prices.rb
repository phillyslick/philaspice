class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.decimal :amount, precision: 9, scale: 2
      t.references :variant
      t.references :weight

      t.timestamps
    end
    add_index :prices, :variant_id
    add_index :prices, :weight_id
  end
end
