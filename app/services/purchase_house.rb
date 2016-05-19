class PurchaseHouse
  attr_reader :game, :event

  def initialize(game:, property:)
    self.game = game
    self.property = property
  end

  def call
    game.with_lock do
      self.event = HousePurchased.new(property: property)
      game.events << event if event.can_apply?(game.state)
    end
  end

  def errors
    event.errors(game.state)
  end

  private

  attr_writer :game, :event
  attr_accessor :property
end
