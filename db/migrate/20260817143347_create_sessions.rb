class CreateSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :sessions do |t|
      t.string :type
      t.float :distance
      t.time :pace
      t.string :content
      t.references :objective, null: false, foreign_key: true

      t.timestamps
    end
  end
end
