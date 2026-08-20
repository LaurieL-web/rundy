class AddStatusColumnToSeances < ActiveRecord::Migration[8.1]
  def change
    add_column :seances, :status, :boolean, default: false
  end
end
