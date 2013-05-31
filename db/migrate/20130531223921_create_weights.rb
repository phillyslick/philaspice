class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.decimal :ounces, precision: 9, scale: 3

      t.timestamps
    end
  end
end
