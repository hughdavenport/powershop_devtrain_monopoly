class Player < ActiveRecord::Base
  after_initialize :default_values

  belongs_to :user
  belongs_to :game

  enum piece: [:wheelbarrow, :battleship, :racecar, :thimble, :boot, :dog, :hat]

  validates :piece, uniqueness: { scope: :game }
  validates :balance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def default_values
    self.balance ||= 1500
  end
end
