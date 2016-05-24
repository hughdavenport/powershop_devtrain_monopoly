class Game < ActiveRecord::Base
  has_many :events, dependent: :destroy
  # TODO get rid of this, should just display from gamestate
  has_many :dice_rolleds
  validates :number_of_players, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: GameState::PIECES.count }

  def state
    @game_state ||= create_game_state
  end

  private

  def create_game_state
    GameState.new(max_number_of_players: number_of_players).tap do |game_state|
      events.each { |event| event.apply(game_state) }
      with_lock do
        if !game_state.chance_cards.nil?
          if game_state.chance_cards.empty?
            event = ChanceCardsShuffled.create(game: self)
            event.apply(game_state)
          end
        end
        if !game_state.community_chest_cards.nil?
          if game_state.community_chest_cards.empty?
            event = CommunityChestCardsShuffled.create(game: self)
            event.apply(game_state)
          end
        end
      end
    end
  end

  attr_accessor :game_state
end
