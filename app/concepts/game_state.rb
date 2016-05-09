class GameState
  attr_accessor :players
  attr_accessor :game

  def self.create(game)
    game.events.inject(GameState.new(game: game)) { |state, event| state = event.apply(state) }
  end

  def initialize(game:)
    self.game = game
    self.players = {}
  end

  def started?
    players.count == game.number_of_players
  end
end
