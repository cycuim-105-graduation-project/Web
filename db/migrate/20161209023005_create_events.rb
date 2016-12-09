class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :feature_img
      t.datetime :start_at
      t.datetime :end_at
      t.datetime :registration_start_at
      t.datetime :registration_end_at
      t.integer :quantity
      t.integer :vacancy
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
