require 'spec_helper'

describe Production do

  ore = Product.new "ore", 4
  energy = Product.new "energy", 1

  class Producer
    attr_accessor :production_cycle
  end

  class Provider
    attr_accessor :storage
  end

  class Receiver
    attr_accessor :storage
  end

  describe 'basics' do
    before :each do
      @provider = Provider.new
      @provider.storage = Storage.new 100
      @provider.storage.store 10.units_of ore

      @producer = Producer.new
      @producer.production_cycle = ProductionCycle.new(10, 1.units_of(energy), 2.units_of(ore))

      @receiver = Receiver.new
      @receiver.storage = Storage.new 100

      @production = Production.new(@producer, @provider, @receiver)
    end

    it "can be instantiated" do
      @production.should_not be_nil
    end

    it "takes required rescources from provider" do
      @provider.storage.content(ore).nr_of_units.should_not be_nil
      @producer.production_cycle.consumption.nr_of_units.should_not be_nil

      units_consumed = @producer.production_cycle.consumption.nr_of_units

      expect {
        @production.produce
      }.to change{@provider.storage.content(ore).nr_of_units}.by(-units_consumed)
    end

    it "puts produced goods into the receiver" do
      @provider.storage.content(ore).nr_of_units.should_not be_nil
      @producer.production_cycle.consumption.nr_of_units.should_not be_nil

      units_produced = @producer.production_cycle.production.nr_of_units

      expect {
        @production.produce
      }.to change{@receiver.storage.content(energy).nr_of_units}.by(units_produced)
    end
  end

  describe 'when the provider cannot provide' do

    before :each do
      @provider = Provider.new
      @provider.storage = Storage.new 100
      @provider.storage.store 1.units_of ore

      @producer = Producer.new
      @producer.production_cycle = ProductionCycle.new(10, 1.units_of(energy), 5.units_of(ore))

      @receiver = Receiver.new
      @receiver.storage = Storage.new 100

      @production = Production.new(@producer, @provider, @receiver)
    end

    it 'will raise an exception' do
      expect {
        @production.produce
      }.to raise_error
    end
  end

  describe 'when the receiver doesnt have enough room' do
    before :each do
      @provider = Provider.new
      @provider.storage = Storage.new 100
      @provider.storage.store 20.units_of ore

      @producer = Producer.new
      @producer.production_cycle = ProductionCycle.new(10, 50.units_of(energy), 5.units_of(ore))

      @receiver = Receiver.new
      @receiver.storage = Storage.new 100
      @receiver.storage.store 99.units_of energy

      @production = Production.new(@producer, @provider, @receiver)
    end

    it 'will raise an error' do
      expect {
        @production.produce
      }.to raise_error
    end
  end

end
