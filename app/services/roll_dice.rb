class RollDice
  attr_reader :game, :player, :dice_roll

  def initialize(game:, player:)
    self.game = game
    self.player = player
  end

  def call
    game.with_lock do
      player.with_lock do
        self.dice_roll = player.dice_rolls.new()
        game.valid? && player.valid? && dice_roll.save
      end
    end
  end

  def errors
    dice_roll.errors.tap do |errors|
      game.errors.delete(:players)
      game.errors.each { |attr, error| errors.add(attr, error) }
      player.errors.delete(:dice_rolls)
      player.errors.each { |attr, error| errors.add(attr, error) }
    end
  end

  private

  attr_writer :game, :player, :dice_roll
end
