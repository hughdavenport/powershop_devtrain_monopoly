class IncomeTaxSquare < Square
  after_initialize :set_name

  private

  def set_name
    self.name = "Income Tax"
  end
end
