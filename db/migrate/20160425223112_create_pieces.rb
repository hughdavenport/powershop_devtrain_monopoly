class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.references :player, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
