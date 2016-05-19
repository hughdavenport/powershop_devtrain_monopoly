class ColouredProperty < Property
  store_accessor :data, :colour
  validates_presence_of :colour
  validates :colour, inclusion: { in: [:brown, :blue, :pink, :orange, :red, :yellow, :green, :purple] }

  store_accessor :data, :rent
  validates_presence_of :rent
  validates :rent, numericality: { only_integer: true, greater_than: 0 }
end
