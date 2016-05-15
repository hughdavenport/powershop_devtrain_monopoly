class LandOnProperty < Event
  def apply(game_state)
    game_state.tap do |game_state|
      game_state.players[game_state.current_player].tap do |player|
        property = game_state.board[player[:location]]
        owner = game_state.property_owner(property)
        if owner.nil?
          # Event for buy
        elsif owner != player
          # Event for tax
        end
      end
    end
  end
end
