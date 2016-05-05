class CreateDiceRolls < ActiveRecord::Migration
  def change
    create_table :dice_rolls do |t|
      t.integer :amount

      t.timestamps null: false
    end
  end
end
