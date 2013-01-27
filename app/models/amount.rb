class Amount
  attr_reader :nr_of_units, :product

  def initialize product, nr_of_units
    @nr_of_units = nr_of_units
    @product = product
  end

  def required_storage_space
    @product.unit_size * @nr_of_units
  end

  def == other
    @nr_of_units == other.nr_of_units
    @product.name == other.product.name
    @product.unit_size == other.product.unit_size
  end

  def to_s
    "#{@nr_of_units} of #{@product.name}"
  end
end
