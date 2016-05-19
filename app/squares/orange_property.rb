class OrangeProperty < ColouredProperty
  after_initialize :set_colour

  private

  def set_colour
    self.colour = :orange
  end
end
