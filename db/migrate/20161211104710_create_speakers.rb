class CreateSpeakers < ActiveRecord::Migration[5.0]
  def change
    create_table :speakers do |t|
      t.string :name
      t.text :description
      t.string :image
      t.references :agenda, foreign_key: true

      t.timestamps
    end
  end
end
