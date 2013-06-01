class AddDescriptionToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :description, :text
  end
end
