class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.string :name
      t.string :picture
      t.boolean :published
      t.integer :position

      t.timestamps
    end
  end
end
