class SuperTaxSquare < Square
  after_initialize :set_name

  def effect
    SuperTaxPaid
  end

  private

  def set_name
    self.name = "Super Tax"
  end
end
