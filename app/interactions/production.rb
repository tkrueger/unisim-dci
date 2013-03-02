class Production

  module Provider
    def provide(amount)
      raise 'cannot provide #{amount}' unless storage.contains? amount
      storage.retrieve(amount)
    end
  end

  module Receiver
   def receive(amount)
     raise 'not enough room for #{amount}' unless storage.has_room_for? amount
     storage.store(amount)
   end
  end

  def initialize(producer, provider, receiver)
    @producer = producer
    @provider = provider
    @receiver = receiver

    @receiver.extend Receiver
    @provider.extend Provider
  end

  def produce
    cycle = @producer.production_cycle

    @provider.provide(cycle.consumption)
    @receiver.receive(cycle.production)

    # TODO unextend objects
  end
end