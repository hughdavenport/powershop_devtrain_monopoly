class AdvanceToStation < Card
  after_initialize :set_name

#  def effect
#    # TODO make an effect
#  end

  private

  def set_name
    self.name ||= "Advance token to nearest Railroad and pay the owner twice the rental to which he/she is otherwise entitled. If Railroad is unowned, you may buy it from the Bank."
  end
end
