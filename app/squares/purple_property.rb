class PurpleProperty < ColouredProperty
  after_initialize :set_colour

  private

  def set_colour
    self.colour = :purple
  end
end
