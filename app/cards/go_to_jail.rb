class GoToJail < Card
  after_initialize :set_name

  def effect
    SentToJail.new
  end

  private

  def set_name
    self.name = "Go to jail - Go directly to jail - Do not pass Go, do not collect $200"
  end
end
