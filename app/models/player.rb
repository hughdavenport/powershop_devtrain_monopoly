class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  enum piece: [:wheelbarrow, :battleship, :racecar, :thimble, :boot, :dog, :hat]
end
