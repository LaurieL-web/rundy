class AddWeekIndexToSeances < ActiveRecord::Migration[8.1]
  def change
    add_column :seances, :week_index, :integer
  end
end
