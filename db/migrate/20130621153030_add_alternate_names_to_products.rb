class AddAlternateNamesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :alternate_names, :text
  end
end
