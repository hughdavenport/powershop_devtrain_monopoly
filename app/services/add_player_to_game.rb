class AddPlayerToGame
  attr_reader :game, :player

  def initialize(game:, user:, piece:)
    self.game = game
    self.user = user
    self.piece = piece
  end

  def call
    game.with_lock do
      self.player = game.players.new(user: user, piece: piece)
      game.valid? && player.save
    end
  end

  def errors
    player.errors.tap do |errors|
      game.errors.delete(:players)
      game.errors.each { |attr, error| errors.add(attr, error) }
    end
  end

  private

  attr_accessor :user, :piece
  attr_writer :game, :player
end
