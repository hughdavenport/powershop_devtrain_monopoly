class GreenProperty < ColouredProperty
  after_initialize :set_colour

  private

  def set_colour
    self.colour = :green
  end
end
