class GoToJailSquare < Square
  after_initialize :set_name

  private

  def set_name
    self.name = "Go To Jail"
  end
end