class AddBalanceToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :balance, :integer
  end
end
