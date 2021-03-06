class Storage

  attr_reader :capacity

  def initialize capacity
    @capacity = capacity
    @contents = Hash.new
  end

  def store amount
    @contents[amount.product] = amount
  end

  def content product
    return Amount.new(product, 0) if @contents[product].nil?
    @contents[product]
  end

  def contains? amount
    return @contents[amount.product] >= amount
  end

  def has_room_for? amount
    free_space > amount.required_storage_space
  end

  def retrieve amount
    @contents[amount.product] -= amount
  end

  # since this is behavior that is essential part of the thing (as opposed to roles it plays),
  # it is allowed to reside here. I like to think of this as physical properties of a model
  # object.
  def free_space
    used_up_space = @contents.values.reduce(0) {|sum, amount| sum + amount.required_storage_space}
    @capacity - used_up_space
  end
end
