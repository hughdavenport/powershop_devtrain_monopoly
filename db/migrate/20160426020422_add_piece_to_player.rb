class AddPieceToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :piece, :integer
  end
end
