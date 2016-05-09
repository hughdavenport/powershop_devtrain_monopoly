class Game < ActiveRecord::Base
  has_many :events, dependent: :destroy
  has_many :dice_rolls
  validates :number_of_players, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: GameState::PIECES.count }

  def state
    @game_state ||= GameState.create(self)
  end

  private

  attr_accessor :game_state
end
