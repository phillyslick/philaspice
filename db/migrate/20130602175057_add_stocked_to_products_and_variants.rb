class AddStockedToProductsAndVariants < ActiveRecord::Migration
  def change
    add_column :products, :stocked, :boolean
    add_column :variants, :stocked, :boolean
  end
end
