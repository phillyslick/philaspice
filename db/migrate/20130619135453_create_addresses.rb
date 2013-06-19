class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :kind
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.references :order

      t.timestamps
    end
    add_index :addresses, :order_id
  end
end
