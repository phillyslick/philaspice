class AddMeasurementToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :measurement, :string
  end
end
