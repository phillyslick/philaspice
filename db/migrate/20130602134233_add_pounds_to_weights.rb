class AddPoundsToWeights < ActiveRecord::Migration
  def change
    add_column :weights, :in_pounds, :boolean, default: false
  end
end
