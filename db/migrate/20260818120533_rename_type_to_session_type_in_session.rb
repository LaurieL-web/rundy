class RenameTypeToSessionTypeInSession < ActiveRecord::Migration[8.1]
  def change
    rename_column :sessions, :type, :session_type
  end
end
