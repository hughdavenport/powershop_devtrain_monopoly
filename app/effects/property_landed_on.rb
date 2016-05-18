class PropertyLandedOn
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    property = game_state.board[player[:location]]
    owner = game_state.property_owner(property)
    if owner.nil?
      game_state.can_buy_property = true
    elsif owner != player
      details = game_state.details(property)
      if details[:station]
        StationRentPaid.new.apply(game_state)
      elsif details[:utility]
        OwnedUtilityLandedOn.new.apply(game_state)
      else
        if game_state.colour_group(details[:colour]).all? { |property| game_state.property_owner(property) == owner }
          FullColourGroupRentPaid.new.apply(game_state)
        else
          RentPaid.new.apply(game_state)
        end
      end
    end
  end
end
