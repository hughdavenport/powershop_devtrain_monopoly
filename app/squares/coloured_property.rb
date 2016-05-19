class ColouredProperty < Property
  store_accessor :data, :colour
  validates_presence_of :colour
  validates :colour, inclusion: { in: [:brown, :blue, :pink, :orange, :red, :yellow, :green, :purple] }

  store_accessor :data, :rent
  validates_presence_of :rent
  validates :rent, numericality: { only_integer: true, greater_than: 0 }

  store_accessor :data, :house_rent
  validates_presence_of :house_rent
  validates :house_rent, length: { is: 4 }
  validate :validate_house_rent

  def building_price
    {
      brown: 50,
      blue: 50,
      pink: 100,
      orange: 100,
      red: 150,
      yellow: 150,
      green: 200,
      purple: 200,
    }.fetch(colour)
  end

  private

  def validate_house_rent
    if !house_rent.is_a?(Array) || house_rent.detect { |rent| !rent.is_a?(Integer) || rent <= 0 }
      errors.add(:house_rent, :invalid)
    end
  end
end
