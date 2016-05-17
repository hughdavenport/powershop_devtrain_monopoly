class SuperTaxPaid < TaxPaid
  after_initialize :default_values

  private

  def default_values
    self.amount ||= 100
  end
end
