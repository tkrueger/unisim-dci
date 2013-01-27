require 'spec_helper'

describe Amount do

  ore = Product.new "ore", 4

  it "depicts a number of units" do
    amount = Amount.new ore, 2
    amount.nr_of_units.should == 2
  end

  it "references a product" do
    amount = Amount.new ore, 2
    amount.product.should == ore
  end

  it "calculates the required storage space" do
    amount = Amount.new ore, 2
    amount.required_storage_space.should == 4 * 2
  end

end
