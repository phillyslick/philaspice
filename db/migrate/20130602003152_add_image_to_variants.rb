class AddImageToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :image, :string
  end
end
