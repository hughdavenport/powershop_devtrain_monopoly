class RedProperty < ColouredProperty
  after_initialize :set_colour

  private

  def set_colour
    self.colour = :red
  end
end
