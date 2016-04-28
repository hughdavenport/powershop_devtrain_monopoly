class AddPlayerToGame
  attr_reader :game, :player

  def initialize(game:, user:, piece:)
    self.game = game
    self.user = user
    self.piece = piece
  end

  def call
    game.with_lock do
      self.player = game.players.create(user: user, piece: piece)
      self.player.save
    end
  end

  def errors
    player.errors if player
  end

  private

  attr_accessor :user, :piece
  attr_writer :game, :player
end
