class AdvanceToUtility < Card
  after_initialize :set_name

#  def effect
#    # TODO make an effect
#  end

  private

  def set_name
    self.name ||= "Advance token to nearest Utility. If unowned, you may buy it from the Bank. If owned, throw dice and pay the owner a total ten times the amount shown."
  end
end
