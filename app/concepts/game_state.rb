class GameState
  attr_accessor :players
  attr_accessor :game
  attr_accessor :current_player

  PIECES = [:wheelbarrow, :battleship, :racecar, :thumble, :boot, :dog, :hat]

  def self.create(game)
    game.events.inject(GameState.new(game: game)) { |state, event| event.apply(state) }
  end

  def initialize(game:)
    self.game = game
    self.players = []
  end

  def started?
    players.count == game.number_of_players
  end

  def pieces_left
    PIECES - players.map { |player| player[:piece].to_sym }
  end

  def player(user)
    players.first { |player| player[:user] == user }
  end
end
