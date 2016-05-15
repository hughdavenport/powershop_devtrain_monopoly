class GameState
  attr_accessor :players
  attr_accessor :game
  attr_accessor :current_player

  PIECES = [:wheelbarrow, :battleship, :racecar, :thumble, :boot, :dog, :hat]
  BOARD  = [
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

  SQUARE_DETAILS = {
    :go => {},
    :jail => {},
    :free_parking => {},

    :income_tax => { event: PayIncomeTax },
    :super_tax  => { event: PaySuperTax },

    :go_to_jail => { event: GoToJail },

    :chance          => {},
    :community_chest => {},

    :kings_cross_station      => { event: LandOnProperty, station: true },
    :marylbone_station        => { event: LandOnProperty, station: true },
    :fenchurch_street_station => { event: LandOnProperty, station: true },
    :liverpool_street_station => { event: LandOnProperty, station: true },

    :electric_company => { event: LandOnProperty, event: LandOnProperty, utility: true },
    :water_works      => { event: LandOnProperty, utility: true },

    :old_kent_road    => { event: LandOnProperty, colour: :brown },
    :whitechapel_road => { event: LandOnProperty, colour: :brown },

    :the_angel_islington => { event: LandOnProperty, colour: :blue },
    :euston_road         => { event: LandOnProperty, colour: :blue },
    :pentonville_road    => { event: LandOnProperty, colour: :blue },

    :pall_mall             => { event: LandOnProperty, colour: :pink },
    :whitehall             => { event: LandOnProperty, colour: :pink },
    :northumberland_avenue => { event: LandOnProperty, colour: :pink },

    :bow_street         => { event: LandOnProperty, colour: :orange },
    :marlborough_street => { event: LandOnProperty, colour: :orange },
    :vine_street        => { event: LandOnProperty, colour: :orange },

    :strand           => { event: LandOnProperty, colour: :red },
    :fleet_street     => { event: LandOnProperty, colour: :red },
    :trafalgar_square => { event: LandOnProperty, colour: :red },

    :leicester_square => { event: LandOnProperty, colour: :yellow },
    :coventry_street  => { event: LandOnProperty, colour: :yellow },
    :piccadilly       => { event: LandOnProperty, colour: :yellow },

    :regent_street => { event: LandOnProperty, colour: :green },
    :oxford_street => { event: LandOnProperty, colour: :green },
    :bond_street   => { event: LandOnProperty, colour: :green },

    :park_lane => { event: LandOnProperty, colour: :purple },
    :mayfair   => { event: LandOnProperty, colour: :purple },
  }

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
    players.select { |player| player[:user] == user }.first
  end

  def players_at(location)
    players.select { |player| player[:position] == location }
  end

  def owned_properties
    players.map { |player| [player[:user], player[:properties]] }.to_h
  end

  def property_owner(property)
    players.select { |player| player[:properties].include?(property) }.first
  end

  def shift_player!(player)
    player[:location] = (player[:location] + player[:dice_rolls].inject(:+)) % board.size
    player[:dice_rolls] = []
  end

  def send_player_to_jail!(player)
    player[:location] = board.index(:jail)
    player[:in_jail] = true
    end_turn!(player)
  end

  def break_out_of_jail!(player)
    player[:in_jail] = false
    player[:pairs_rolled_while_in_jail] = 0
    end_turn!(player)
  end

  def end_turn!(player)
    player[:dice_rolls] = []
    player[:doubles_in_a_row] = 0
    self.current_player = (current_player + 1) % players.size if player == players[current_player]
  end

  def board
    BOARD
  end

  def details(square)
    SQUARE_DETAILS[square]
  end
end
