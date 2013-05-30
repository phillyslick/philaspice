class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.datetime :deleted_at
      t.boolean :featured
      t.boolean :active

      t.timestamps
    end
  end
end
