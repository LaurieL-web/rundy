class CreateObjectives < ActiveRecord::Migration[8.1]
  def change
    create_table :objectives do |t|
      t.integer :distance
      t.time :target_time
      t.integer :prepa_duration
      t.integer :frequency

      t.timestamps
    end
  end
end
