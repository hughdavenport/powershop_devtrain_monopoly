class Collect < Card
  store_accessor :data, :amount
  validates_presence_of :amount
  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  def effect
    # negative tax
    TaxPaid.new(amount: -amount)
  end
end
