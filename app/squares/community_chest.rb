class CommunityChest < Square
  after_initialize :set_name

  def effect
    DrawCardSquareLandedOn
  end

  private

  def set_name
    self.name = "Community Chest"
  end
end
