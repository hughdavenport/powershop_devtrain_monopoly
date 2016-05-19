class CreateSquare < ActiveRecord::Migration
  def change
    create_table :squares do |t|
      t.string "name", null: false
      t.string "type"
      t.string "data"
      t.timestamps null: false
    end
  end
end
