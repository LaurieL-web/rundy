class ChangeTargetTimeType < ActiveRecord::Migration[8.1]
  def change
    change_column :objectives, :target_time, :string
  end
end
