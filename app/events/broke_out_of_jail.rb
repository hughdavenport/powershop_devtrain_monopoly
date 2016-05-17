class BrokeOutOfJail < BondPosted
  after_initialize :default_values

  private

  def default_values
    self.amount = 0
  end
end
