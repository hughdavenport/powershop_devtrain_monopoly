class IncomeTaxSquare < Square
  after_initialize :set_name

  def effect
    IncomeTaxPaid
  end

  private

  def set_name
    self.name = "Income Tax"
  end
end
