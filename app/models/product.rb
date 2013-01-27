class Product
  # attr_accessible :title, :body
  attr_reader :name, :unit_size

  def initialize name, unit_size = 1
    @name = name
    @unit_size = unit_size
  end

end
