class PayIncomeTax < PayTax
  def apply(game_state)
    game_state.tap do |game_state|
      game_state.players[game_state.current_player].tap do |player|
        self.amount = [200].min
        super
      end
    end
  end
end
