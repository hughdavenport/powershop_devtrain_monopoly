class StreetRepairs < Card
  store_accessor :data, :per_house
  validates_presence_of :per_house
  validates :per_house, numericality: { only_integer: true, greater_than: 0 }

  store_accessor :data, :per_hotel
  validates_presence_of :per_hotel
  validates :per_hotel, numericality: { only_integer: true, greater_than: 0 }

  def effect
    # TODO make effect for this
  end
end
