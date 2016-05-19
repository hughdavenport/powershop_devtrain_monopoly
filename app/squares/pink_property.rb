class PinkProperty < ColouredProperty
  after_initialize :set_colour

  private

  def set_colour
    self.colour = :pink
  end
end
