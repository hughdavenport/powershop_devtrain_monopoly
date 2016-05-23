class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string "name", null: false
      t.string "type"
      t.string "data"
      t.integer "card_type"
      t.timestamps null: false
    end
  end
end
