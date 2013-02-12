class ProductionCycle
  attr_reader :length, :consumption, :production

  def initialize length, production , consumption = nil
    @length, @consumption, @production = length, consumption, production
  end
end
