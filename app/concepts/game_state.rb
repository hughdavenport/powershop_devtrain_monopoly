class GameState
  attr_accessor :players
  attr_accessor :max_number_of_players
  attr_accessor :current_player
  attr_accessor :can_buy_property
  attr_accessor :expecting_rolls

  MAX_HOUSES = 32
  MAX_HOTELS = 12
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

  def initialize(max_number_of_players:)
    self.max_number_of_players = max_number_of_players
    self.expecting_rolls = 2
    self.players = []
  end

  def started?
    players.count == max_number_of_players
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

  def num_houses
    players.map { |player| player.houses.values.inject(0, :+) - player.hotels.count * 4 }.inject(0, :+)
  end

  def num_hotels
    players.map { |player| player.hotels.count }.inject(0, :+)
  end

  def can_buy_property?
    can_buy_property
  end

  def can_buy_house?
    num_houses < MAX_HOUSES
  end

  def can_buy_hotel?
    num_hotels < MAX_HOTELS
  end

  def shift_player!(player, amount)
    player.shift!(amount)
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
end
