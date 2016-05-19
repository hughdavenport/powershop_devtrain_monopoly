class PropertyLandedOn
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    property = game_state.board[player.location]
    owner = game_state.property_owner(property)
    if owner.nil?
      game_state.can_buy_property = true
    elsif owner != player
      if property.is_a?(StationProperty)
        StationRentPaid.new.apply(game_state)
      elsif property.is_a?(UtilityProperty)
        OwnedUtilityLandedOn.new.apply(game_state)
      elsif property.is_a?(ColouredProperty)
        if property.class.name.constantize.all.all? { |property| game_state.property_owner(property) == owner }
          FullColourGroupRentPaid.new.apply(game_state)
        else
          RentPaid.new.apply(game_state)
        end
      end
    end
  end
end
