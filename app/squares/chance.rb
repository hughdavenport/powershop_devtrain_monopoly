class Chance < Square
  after_initialize :set_name

  def effect
    DrawCardSquareLandedOn
  end

  private

  def set_name
    self.name = "Chance"
  end
end
