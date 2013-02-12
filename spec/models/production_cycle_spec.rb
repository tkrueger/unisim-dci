require 'spec_helper'

describe ProductionCycle do
  it "takes empty consumption" do
    ore = Product.new "ore", 4
    cycle = ProductionCycle.new 100, (2.units_of ore)
    cycle.length.should == 100
    cycle.production.should == (2.units_of ore)
    cycle.consumption.should be_nil
  end

  it "takes consumption and production" do
    ore = Product.new "ore", 4
    energy = Product.new "energy", 1

    cycle = ProductionCycle.new 100, (2.units_of ore), (5.units_of energy)
    cycle.length.should == 100
    cycle.production.should == (2.units_of ore)
    cycle.consumption.should == (5.units_of energy)
  end
end
