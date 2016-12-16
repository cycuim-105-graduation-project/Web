class CreateCheckins < ActiveRecord::Migration[5.0]
  def change
    create_table :checkins do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :agenda, foreign_key: true
      t.timestamps
    end
  end
end
