class PlayerBankrupted
  attr_reader :owner

  def initialize(owner: nil)
    self.owner = owner
  end

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    game_state.bankrupt!(player, owner)
  end

  private

  attr_writer :owner
end
