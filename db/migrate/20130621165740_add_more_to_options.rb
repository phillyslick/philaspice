class AddMoreToOptions < ActiveRecord::Migration
  def change
    add_column :options, :cat_info, :text
    add_column :options, :cat_heading, :string
  end
end
