class Amount
  attr_reader :nr_of_units, :product

  def initialize product, nr_of_units
    raise "argument 'product' is mandatory" if product == nil
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

  def - other
    (@nr_of_units - other.nr_of_units).units_of @product
  end

  def > other
    raise ArgumentError.new unless other.product == @product
    @nr_of_units > other.nr_of_units
  end

  def >= other
    @nr_of_units >= other.nr_of_units
  end

  def < other
    raise ArgumentException.new unless other.product == @product
    @nr_of_units < other.nr_of_units
  end

  def <= other
    raise ArgumentError.new unless other.product == @product
    @nr_of_units <= other.nr_of_units
  end

  def to_s
    "#{@nr_of_units} of #{@product.name}"
  end

end

class Fixnum
  def units_of a_product
    Amount.new a_product, self
  end
end
