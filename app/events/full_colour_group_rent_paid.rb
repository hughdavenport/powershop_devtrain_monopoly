class FullColourGroupRentPaid < RentPaid
  def apply(game_state)
    2.times { super } # Double rent
  end
end
