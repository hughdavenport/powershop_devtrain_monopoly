class IncomeTaxSquare < Square
  after_initialize :set_name

  def event
    IncomeTaxPaid
  end

  private

  def set_name
    self.name = "Income Tax"
  end
end
