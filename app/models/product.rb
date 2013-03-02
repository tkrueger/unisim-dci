class Product
  # attr_accessible :title, :body
  attr_reader :name, :unit_size

  def initialize name, unit_size = 1
    @name = name
    @unit_size = unit_size
  end

  def == other
    return false unless other.instance_of? Product
    return other.name == @name
  end
end
