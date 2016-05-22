class Player
  attr_reader :user,
              :piece,
              :money,
              :location,
              :jail,
              :dice_rolls,
              :properties,
              :houses,
              :hotels

  # TODO make just a reader and deal with this a diferent way
  attr_accessor :doubles_in_a_row,
                :pairs_rolled_while_in_jail

  def initialize(user:, piece:)
    self.user = user
    self.piece = piece
    self.money = 1500
    self.location = 0
    self.jail = false
    self.dice_rolls = []
    self.doubles_in_a_row = 0
    self.pairs_rolled_while_in_jail = 0
    self.properties = []
    self.houses = {}
    self.hotels = {}
  end

  def roll_dice(amount)
    self.dice_rolls << amount
  end

  def jail?
    jail
  end

  def can_afford?(amount)
    money >= amount
  end

  def owns_property?(property)
    properties.include?(property)
  end

  def can_buy_house?(property)
    possible_house_locations.include?(property)
  end

  def can_buy_hotel?(property)
    possible_hotel_locations.include?(property)
  end

  def has_buildings_on?(property)
    houses.include?(property.name)
  end

  def possible_house_locations
    # TODO Need to make sure this is evenly buildable
    # TODO Need to make this cleaner
    colour_groups_owned.map do |colour|
      properties.select { |property| property.colour == colour if property.is_a?(ColouredProperty) }
    end.each do |colour_group|
      min = houses[colour_group.min { |a, b| houses.fetch(a.name, 0) <=> houses.fetch(b.name, 0) }.name]
      colour_group.select! { |property| houses[property.name] == min }
    end.flatten.select do |property|
      can_afford?(property.building_price)
    end.map do |property|
      property.name
    end - possible_hotel_locations - hotels.keys
  end

  def possible_hotel_locations
    # TODO Need to make sure this is evenly buildable
    colour_groups_owned.map do |colour|
      properties.select { |property| property.colour == colour if property.is_a?(ColouredProperty) }
    end.each do |colour_group|
      min = houses[colour_group.min { |a, b| houses.fetch(a.name, 0) <=> houses.fetch(b.name, 0) }.name]
      colour_group.select! { |property| houses[property.name] == min }
    end.flatten.select do |property|
      can_afford?(property.building_price)
    end.map do |property|
      property.name
    end.select { |property| houses[property] == 4 } - hotels.keys
  end

  def purchase_house!(property)
    self.houses[property] ||= 0
    self.houses[property] += 1
    pay!(ColouredProperty.find_by_name(property).building_price)
  end

  def purchase_hotel!(property)
    self.hotels[property] = true
    pay!(ColouredProperty.find_by_name(property).building_price)
  end

  def shift!(amount)
    self.location += amount
    self.location %= GameState::BOARD.size
    self.dice_rolls = []
  end

  def send_to_jail!
    self.location = GameState::BOARD.index { |property| property.name == "Jail" }
    self.jail = true
  end

  def break_out_of_jail!
    self.jail = false
    self.pairs_rolled_while_in_jail = 0
  end

  def end_turn!
    self.dice_rolls = []
    self.doubles_in_a_row = 0
  end

  def pay!(amount, to_player = nil)
    self.money -= amount
    to_player.earn!(amount) if to_player
  end

  def earn!(amount)
    self.money += amount
  end

  def add_property!(property)
    self.properties << property
  end

  def set_balance!(amount)
    self.money = amount
  end

  private

  def uniq_colours_owned
    properties.map { |property| property.colour if property.is_a?(ColouredProperty) }.compact.uniq
  end

  def colour_groups_owned
    uniq_colours_owned.select do |colour|
      total_count = ColouredProperty.select { |property| property.colour == colour }.count
      my_count = properties.select { |property| property.colour == colour if property.is_a? ColouredProperty }.count

      total_count == my_count
    end
  end

  attr_writer :user,
              :piece,
              :money,
              :location,
              :jail,
              :dice_rolls,
# TODO make these writers, and change how we do it, see accessor statement at top
#              :doubles_in_a_row,
#              :pairs_rolled_while_in_jail,
              :properties,
              :houses,
              :hotels
end
