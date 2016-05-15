class BuyProperty
  attr_reader :game, :event

  def initialize(game:)
    self.game = game
  end

  def call
    game.with_lock do
      self.event = PurchaseProperty.new
      game.events << event if event.can_apply?(game.state)
    end
  end

  def errors
    event.errors(game.state)
  end

  private

  attr_writer :game, :event
end
