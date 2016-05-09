class Events::DiceRoll < Event
  after_initialize :default_values
  store_accessor :data, :amount

  private

  def default_values
    self.amount ||= (Random.rand(6) + 1)
  end
end
