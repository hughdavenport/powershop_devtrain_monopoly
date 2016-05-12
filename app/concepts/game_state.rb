class GameState
  attr_accessor :players
  attr_accessor :game
  attr_accessor :current_player

  PIECES = [:wheelbarrow, :battleship, :racecar, :thumble, :boot, :dog, :hat]

  def self.create(game)
    game.events.inject(GameState.new(game: game)) { |state, event| event.apply(state) }
  end

  def initialize(game:)
    self.game = game
    self.players = []
  end

  def started?
    players.count == game.number_of_players
  end

  def pieces_left
    PIECES - players.map { |player| player[:piece].to_sym }
  end

  def player(user)
    players.first { |player| player[:user] == user }
  end

  def players_at(location)
    players.select { |player| player[:position] == location }
  end

  def board
    [
      :go,
      :old_kent_road,
      :community_chest,
      :whitechapel_road,
      :income_tax,
      :kings_cross_station,
      :the_angel_islington,
      :chance,
      :euston_road,
      :pentonville_road,
      :jail,
      :pall_mall,
      :electric_company,
      :whitehall,
      :northumberland_avenue,
      :marylbone_station,
      :bow_street,
      :community_chest,
      :marlborough_street,
      :vine_street,
      :free_parking,
      :strand,
      :chance,
      :fleet_street,
      :trafalgar_square,
      :fenchurch_street_station,
      :leicester_square,
      :coventry_street,
      :water_works,
      :piccadilly,
      :go_to_jail,
      :regent_street,
      :oxford_street,
      :community_chest,
      :bond_street,
      :liverpool_street_station,
      :chance,
      :park_lane,
      :super_tax,
      :mayfair
    ]
  end
end
