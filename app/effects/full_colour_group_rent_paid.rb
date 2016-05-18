class FullColourGroupRentPaid
  def apply(game_state)
    2.times { RentPaid.new.apply(game_state) } # Double rent
  end
end
