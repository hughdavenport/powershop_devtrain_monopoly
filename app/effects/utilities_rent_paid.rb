class UtilitiesRentPaid
  attr_reader :dice_roll

  def initialize(dice_roll:)
    self.dice_roll = dice_roll
  end

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    property = game_state.board[player[:location]]
    owner = game_state.property_owner(property)
    utilities_owned = owner[:properties].select { |property| game_state.details(property)[:utility] }.count
    RentPaid.new(amount: dice_roll * (utilities_owned == 1 ? 4 : 10)).apply(game_state)
  end

  private

  attr_writer :dice_roll
end
