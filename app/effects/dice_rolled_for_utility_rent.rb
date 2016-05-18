class DiceRolledForUtilityRent
  attr_reader :dice_roll

  def initialize(dice_roll:)
    self.dice_roll = dice_roll
  end

  def apply(game_state)
    UtilitiesRentPaid.new(dice_roll: dice_roll).apply(game_state)
  end

  private

  attr_writer :dice_roll
end
