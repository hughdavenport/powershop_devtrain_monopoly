class DiceRoll < ActiveRecord::Base
  after_initialize :default_values
  belongs_to :player
  has_one :game, through: :player

  private

  def default_values
    self.amount ||= (Random.rand(6) + 1)
  end
end
