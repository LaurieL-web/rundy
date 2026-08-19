class RenameSessionToSeance < ActiveRecord::Migration[8.1]
  def change
    rename_table :sessions, :seances
  end
end
