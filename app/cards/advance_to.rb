class AdvanceTo < Card
  after_initialize :set_name

  store_accessor :data, :location
  validates_presence_of :location

  def effect
    PlayerAdvanced.new(location: location)
  end

  private

  def set_name
    self.name ||= "Advance to #{location} #{location == "Go" ? " (Collect $200)" : "- If you pass Go, collect $200"}"
  end
end
