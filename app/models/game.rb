class Game < ActiveRecord::Base
  has_many :players, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :dice_rolls, class_name: "Events::DiceRoll"
  validates_each :players do |game, attr, value|
    game.errors.add :base, :game_is_full if game.players.size > game.number_of_players
  end
  validates :number_of_players, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: Player.pieces.count }

  def state
    @game_state ||= GameState.create(self)
  end

  private

  attr_accessor :game_state
end
