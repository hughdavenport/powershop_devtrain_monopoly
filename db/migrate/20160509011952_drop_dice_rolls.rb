class DropDiceRolls < ActiveRecord::Migration
  def change
    drop_table :dice_rolls
  end
end
