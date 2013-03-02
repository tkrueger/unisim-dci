require 'spec_helper'

describe Amount do

  ore = Product.new "ore", 4
  silicon = Product.new 'silicon', 1

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

  it "extends Fixnum for ease of use" do
    amount = 10.units_of ore
    amount.product.should == ore
    amount.nr_of_units.should == 10
  end

  it "needs a product argument" do
    expect { Amount.new nil, 2 }.to raise_error
  end

  it 'can be subtracted' do
    (10.units_of(ore) - 5.units_of(ore)).should eq 5.units_of ore
  end

  describe 'comparing' do
    it 'will fail on differen products' do
      expect { (10.units_of(ore) > 10.units_of(silicon))}.to raise_error ArgumentError
    end
    it 'can check for greater than' do
      (10.units_of(ore) > 5.units_of(ore)).should == true
      (10.units_of(ore) > 10.units_of(ore)).should == false
      (10.units_of(ore) > 15.units_of(ore)).should == false
    end

    it 'can check for smaller than' do
      (10.units_of(ore) < 5.units_of(ore)).should == false
      (10.units_of(ore) < 10.units_of(ore)).should == false
      (10.units_of(ore) < 15.units_of(ore)).should == true
    end
  end
end
