class RollDice
  attr_reader :game, :event

  def initialize(game:, amount:)
    self.game = game
    self.amount = amount # Only controller can send this, test whether in test mode there
  end

  def call
    game.with_lock do
      self.event = DiceRolled.new(amount: amount)
      game.events << event if event.can_apply?(game.state)
    end
  end

  def errors
    event.errors(game.state)
  end

  private

  attr_writer :game, :event
  attr_accessor :amount
end
