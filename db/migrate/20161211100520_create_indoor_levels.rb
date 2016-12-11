class CreateIndoorLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :indoor_levels do |t|
      t.string :name
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
