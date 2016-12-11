class CreateSpeackers < ActiveRecord::Migration[5.0]
  def change
    create_table :speackers do |t|
      t.string :name
      t.string :description
      t.string :image
      t.references :agenda, foreign_key: true

      t.timestamps
    end
  end
end
