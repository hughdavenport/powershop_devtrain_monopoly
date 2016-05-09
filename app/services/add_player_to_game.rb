class AddPlayerToGame
  attr_reader :game, :event

  def initialize(game:, user:, piece:)
    self.game = game
    self.user = user
    self.piece = piece
  end

  def call
    game.with_lock do
      self.event = PlayerJoined.new(user: user.id, piece: piece)
      game.events << event
    end
  end

  def errors
    event.errors
  end

  private

  def gamestate
    game.state
  end

  attr_accessor :user, :piece
  attr_writer :game, :event
end
