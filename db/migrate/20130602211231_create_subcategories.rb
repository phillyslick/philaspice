class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :name
      t.references :category

      t.timestamps
    end
    add_index :subcategories, :category_id
  end
end
