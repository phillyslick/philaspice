class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.references :product
      t.string :sku
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.datetime :deleted_at
      t.boolean :master

      t.timestamps
    end
    add_index :variants, :product_id
  end
end
