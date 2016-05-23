class CreateGame
  attr_reader :game

  def initialize(number_of_players:)
    self.number_of_players = number_of_players
  end

  def call
    self.game = Game.new(number_of_players: number_of_players)
    game.save
  end

  def errors
    game.errors
  end

  private

  attr_accessor :number_of_players
  attr_writer :game
end
