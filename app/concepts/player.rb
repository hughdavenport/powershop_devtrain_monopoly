class Player
  attr_reader :user,
              :piece,
              :money,
              :location,
              :jail,
              :dice_rolls,
              :properties

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

  def shift!
    self.location = (self.location + self.dice_rolls.inject(:+)) % GameState::BOARD.size
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

  attr_writer :user,
              :piece,
              :money,
              :location,
              :jail,
              :dice_rolls,
# TODO make these writers, and change how we do it, see accessor statement at top
#              :doubles_in_a_row,
#              :pairs_rolled_while_in_jail,
              :properties
end
