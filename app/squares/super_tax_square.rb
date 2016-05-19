class SuperTaxSquare < Square
  after_initialize :set_name

  private

  def set_name
    self.name = "Super Tax"
  end
end
