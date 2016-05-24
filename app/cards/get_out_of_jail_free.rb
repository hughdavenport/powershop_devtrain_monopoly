class GetOutOfJailFree < Card
  after_initialize :set_name

#  def effect
#    # TODO make effect that adds this to players "inventory"
#  end

  private

  def set_name
    self.name = "Get out of Jail Free - This card may be kept until needed, or traded/sold"
  end
end
