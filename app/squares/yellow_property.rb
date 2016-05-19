class YellowProperty < ColouredProperty
  after_initialize :set_colour

  private

  def set_colour
    self.colour = :yellow
  end
end
