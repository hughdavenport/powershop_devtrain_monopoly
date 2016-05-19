class StationProperty < Property
  after_initialize :set_price

  private

  def set_price
    self.price = 200
  end
end
