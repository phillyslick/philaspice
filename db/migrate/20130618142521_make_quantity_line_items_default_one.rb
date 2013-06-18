class MakeQuantityLineItemsDefaultOne < ActiveRecord::Migration
  def up
    remove_column :line_items, :quantity
    add_column :line_items, :quantity, :integer, default: 1
  end

  def down
    remove_column :line_items, :quantity
    add_column :line_items, :quantity, :integer
  end
end
