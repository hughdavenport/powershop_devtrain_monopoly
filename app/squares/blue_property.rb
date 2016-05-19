class BlueProperty < ColouredProperty
  after_initialize :set_colour

  private

  def set_colour
    self.colour = :blue
  end
end
