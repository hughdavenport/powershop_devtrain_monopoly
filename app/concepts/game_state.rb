class GameState
  attr_accessor :players
  attr_accessor :game
  attr_accessor :current_player
  attr_accessor :can_buy_property
  attr_accessor :expecting_rolls

  PIECES = [:wheelbarrow, :battleship, :racecar, :thumble, :boot, :dog, :hat]
  BOARD  = [
    Square.find_by_name("Go"),
    Square.find_by_name("Old Kent Road"),
    Square.find_by_name("Community Chest"),
    Square.find_by_name("Whitechapel Road"),
    Square.find_by_name("Income Tax"),
    Square.find_by_name("Kings Cross Station"),
    Square.find_by_name("The Angel Islington"),
    Square.find_by_name("Chance"),
    Square.find_by_name("Euston Road"),
    Square.find_by_name("Pentonville Road"),
    Square.find_by_name("Jail"),
    Square.find_by_name("Pall Mall"),
    Square.find_by_name("Electric Company"),
    Square.find_by_name("Whitehall"),
    Square.find_by_name("Northumberland Avenue"),
    Square.find_by_name("Marylbone Station"),
    Square.find_by_name("Bow Street"),
    Square.find_by_name("Community Chest"),
    Square.find_by_name("Marlborough Street"),
    Square.find_by_name("Vine Street"),
    Square.find_by_name("Free Parking"),
    Square.find_by_name("Strand"),
    Square.find_by_name("Chance"),
    Square.find_by_name("Fleet Street"),
    Square.find_by_name("Trafalgar Square"),
    Square.find_by_name("Fenchurch Street Station"),
    Square.find_by_name("Leicester Square"),
    Square.find_by_name("Coventry Street"),
    Square.find_by_name("Water Works"),
    Square.find_by_name("Piccadilly"),
    Square.find_by_name("Go To Jail"),
    Square.find_by_name("Regent Street"),
    Square.find_by_name("Oxford Street"),
    Square.find_by_name("Community Chest"),
    Square.find_by_name("Bond Street"),
    Square.find_by_name("Liverpool Street Station"),
    Square.find_by_name("Chance"),
    Square.find_by_name("Park Lane"),
    Square.find_by_name("Super Tax"),
    Square.find_by_name("Mayfair")
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

    :bow_street         => { event: PropertyLandedOn, colour: :orange, price: 180, rent: 14 },
    :marlborough_street => { event: PropertyLandedOn, colour: :orange, price: 180, rent: 14 },
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
    PIECES - players.map { |player| player.piece.to_sym }
  end

  def player(user)
    players.select { |player| player.user == user }.first
  end

  def player_with_piece(piece)
    players.select { |player| player.piece == piece }.first
  end

  def players_at(location)
    players.select { |player| player.position == location }
  end

  def owned_properties
    players.map { |player| [player.user, player.properties] }.to_h
  end

  def property_owner(property)
    players.select { |player| player.owns_property?(property) }.first
  end

  def colour_group(colour)
    SQUARE_DETAILS.select { |property, details| details[:colour] == colour }.keys
  end

  def can_buy_property?
    can_buy_property
  end

  def shift_player!(player)
    player.shift!
    self.can_buy_property = false
  end

  def send_player_to_jail!(player)
    player.send_to_jail!
    end_turn!(player)
  end

  def break_out_of_jail!(player)
    player.break_out_of_jail!
    end_turn!(player)
  end

  def purchase_property!(player, property)
    player.pay!(property.price)
    player.add_property!(property)
    self.can_buy_property = false
  end

  def end_turn!(player)
    player.end_turn!
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
