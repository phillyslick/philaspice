class AddBasePriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :base_price, :decimal, precision: 8, scale: 2
  end
end
