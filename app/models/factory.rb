class Factory
  attr_reader :id, :production_cycle, :storage

  def initialize id, production_cycle, storage
    @id = id
    @production_cycle = production_cycle
    @storage = storage
  end

end
