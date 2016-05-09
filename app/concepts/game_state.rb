class GameState
  attr_accessor :players
  attr_accessor :game

  PIECES = [:wheelbarrow, :battleship, :racecar, :thumble, :boot, :dog, :hat]

  def self.create(game)
    game.events.inject(GameState.new(game: game)) { |state, event| event.apply(state) }
  end

  def initialize(game:)
    self.game = game
    self.players = {}
  end

  def started?
    players.count == game.number_of_players
  end

  def pieces_left
    PIECES - players.values.map { |player| player[:piece].to_sym }
  end
end
