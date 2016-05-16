class SetBalance < Event
  store_accessor :data, :amount

  def apply(game_state)
    game_state.tap do |game_state|
      game_state.players[game_state.current_player].tap do |player|
        player[:money] = amount.to_i
      end
    end
  end
end
