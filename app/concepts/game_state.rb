class GameState
  attr_accessor :players
  attr_accessor :game
  attr_accessor :current_player
  attr_accessor :can_buy_property
  attr_accessor :expecting_rolls

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

    :income_tax => { event: IncomeTaxPaid },
    :super_tax  => { event: SuperTaxPaid },

    :go_to_jail => { event: SentToJail },

    :chance          => {},
    :community_chest => {},

    :kings_cross_station      => { event: PropertyLandedOn, station: true, price: 200 },
    :marylbone_station        => { event: PropertyLandedOn, station: true, price: 200 },
    :fenchurch_street_station => { event: PropertyLandedOn, station: true, price: 200 },
    :liverpool_street_station => { event: PropertyLandedOn, station: true, price: 200 },

    :electric_company => { event: PropertyLandedOn, utility: true, price: 150 },
    :water_works      => { event: PropertyLandedOn, utility: true, price: 150 },

    :old_kent_road    => { event: PropertyLandedOn, colour: :brown, price: 60, rent: 2 },
    :whitechapel_road => { event: PropertyLandedOn, colour: :brown, price: 60, rent: 4 },

    :the_angel_islington => { event: PropertyLandedOn, colour: :blue, price: 100, rent: 6 },
    :euston_road         => { event: PropertyLandedOn, colour: :blue, price: 100, rent: 6 },
    :pentonville_road    => { event: PropertyLandedOn, colour: :blue, price: 120, rent: 8 },

    :pall_mall             => { event: PropertyLandedOn, colour: :pink, price: 140, rent: 10 },
    :whitehall             => { event: PropertyLandedOn, colour: :pink, price: 140, rent: 10 },
    :northumberland_avenue => { event: PropertyLandedOn, colour: :pink, price: 160, rent: 12 },

    :bow_street         => { event: PropertyLandedOn, colour: :orange, price: 100, rent: 14 },
    :marlborough_street => { event: PropertyLandedOn, colour: :orange, price: 100, rent: 14 },
    :vine_street        => { event: PropertyLandedOn, colour: :orange, price: 200, rent: 16 },

    :strand           => { event: PropertyLandedOn, colour: :red, price: 220, rent: 18 },
    :fleet_street     => { event: PropertyLandedOn, colour: :red, price: 220, rent: 18 },
    :trafalgar_square => { event: PropertyLandedOn, colour: :red, price: 240, rent: 20 },

    :leicester_square => { event: PropertyLandedOn, colour: :yellow, price: 260, rent: 22 },
    :coventry_street  => { event: PropertyLandedOn, colour: :yellow, price: 260, rent: 22 },
    :piccadilly       => { event: PropertyLandedOn, colour: :yellow, price: 280, rent: 24 },

    :regent_street => { event: PropertyLandedOn, colour: :green, price: 300, rent: 26 },
    :oxford_street => { event: PropertyLandedOn, colour: :green, price: 300, rent: 26 },
    :bond_street   => { event: PropertyLandedOn, colour: :green, price: 320, rent: 28 },

    :park_lane => { event: PropertyLandedOn, colour: :purple, price: 350, rent: 35 },
    :mayfair   => { event: PropertyLandedOn, colour: :purple, price: 400, rent: 50 },
  }

  def self.create(game)
    GameState.new(game: game).tap do |game_state|
      game.events.each { |event| event.apply(game_state) }
    end
  end

  def initialize(game:)
    self.game = game
    self.expecting_rolls = 2
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

  def colour_group(colour)
    SQUARE_DETAILS.select { |property, details| details[:colour] == colour }.keys
  end

  def can_buy_property?
    can_buy_property
  end

  def shift_player!(player)
    player[:location] = (player[:location] + player[:dice_rolls].inject(:+)) % board.size
    player[:dice_rolls] = []
    self.can_buy_property = false
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

  def purchase_property!(player, property)
    player[:money] -= details(property)[:price]
    player[:properties] << property
  end

  def end_turn!(player)
    player[:dice_rolls] = []
    player[:doubles_in_a_row] = 0
    self.can_buy_property = false
    self.expecting_rolls = 2
    self.current_player = (current_player + 1) % players.size if player == players[current_player]
  end

  def board
    BOARD
  end

  def details(square)
    SQUARE_DETAILS[square]
  end
end
