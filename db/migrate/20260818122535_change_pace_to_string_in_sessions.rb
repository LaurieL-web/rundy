class ChangePaceToStringInSessions < ActiveRecord::Migration[8.1]
  def change
    change_column :sessions, :pace, :string
  end
end
