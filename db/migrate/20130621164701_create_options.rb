class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :product
      t.string :image

      t.timestamps
    end
    add_index :options, :product_id
  end
end
