class Property < Square
  store_accessor :data, :price
  validates_presence_of :price
  validates :price, numericality: { only_integer: true, greater_than: 0 }

  def effect
    PropertyLandedOn
  end
end
