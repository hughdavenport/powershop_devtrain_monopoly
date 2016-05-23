class PlayerAdvanced
  attr_reader :location

  def initialize(location:)
    self.location = location
  end

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    from = player.location
    to = game_state.board.index { |square| square.name == location }
    to += game_state.board.size if to < from
    PlayerShifted.new(amount: (to - from)).apply(game_state)
  end

  private

  attr_writer :location
end
