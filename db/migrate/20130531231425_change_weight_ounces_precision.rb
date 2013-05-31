class ChangeWeightOuncesPrecision < ActiveRecord::Migration
  def up
    change_column :weights, :ounces, :decimal, precision: 9, scale: 4
  end

  def down
    change_column :weights, :ounces, :decimal, precision: 9, scale: 3
  end
end
