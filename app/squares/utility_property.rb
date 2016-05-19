class UtilityProperty < Property
  after_initialize :set_price

  private

  def set_price
    self.price = 150
  end
end
