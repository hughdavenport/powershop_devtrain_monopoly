class ShuffleChanceCards
  attr_reader :game, :event

  def initialize(game:)
    self.game = game
  end

  def call
    game.with_lock do
      self.event = ChanceCardsShuffled.new
      game.events << event if event.can_apply?(game_state)
    end
  end

  def errors
    event.errors(game_state)
  end

  private

  def game_state
    game.state
  end

  attr_writer :game, :event
end
