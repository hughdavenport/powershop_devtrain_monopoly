class RollDice
  attr_reader :game, :dice_roll

  def initialize(game:)
    self.game = game
  end

  def call
    game.with_lock do
      self.dice_roll = game.dice_rolls.new()
      game.valid? && dice_roll.save
    end
  end

  def errors
    dice_roll.errors.tap do |errors|
      game.errors.delete(:dice_rolls)
      game.errors.each { |attr, error| errors.add(attr, error) }
    end
  end

  private

  attr_writer :game, :dice_roll
end
