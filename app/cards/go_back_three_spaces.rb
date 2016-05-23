class GoBackThreeSpaces < Card
  after_initialize :set_name

  def effect
    PlayerShifted.new(amount: -3)
  end

  private

  def set_name
    self.name = "Go Back 3 Spaces"
  end
end
