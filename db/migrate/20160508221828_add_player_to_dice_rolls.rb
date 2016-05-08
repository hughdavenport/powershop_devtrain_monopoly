class AddPlayerToDiceRolls < ActiveRecord::Migration
  def change
    add_reference :dice_rolls, :player, index: true, foreign_key: true
  end
end
