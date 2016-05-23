class DrawCard
  attr_reader :game, :event

  def initialize(game:, card:)
    self.game = game
    self.card = card # Only controller can send this, test whether in test mode there
  end

  def call
    game.with_lock do
      self.event = CardDrawn.new(card: card)
      game.events << event if event.can_apply?(game.state)
    end
  end

  def errors
    event.errors(game.state)
  end

  private

  attr_writer :game, :event
  attr_accessor :card
end
