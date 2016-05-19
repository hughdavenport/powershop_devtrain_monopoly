class BrownProperty < ColouredProperty
  after_initialize :set_colour

  private

  def set_colour
    self.colour = :brown
  end
end
