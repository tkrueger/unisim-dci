require 'spec_helper'

describe Product do
  it "should have a name" do
    Product.new("some product").name.should == "some product"
  end

  it "has a default unit size of 1" do
    Product.new("some product").unit_size.should == 1
  end

  it "should have a unit size" do
    Product.new("some product", 1).unit_size.should == 1
  end
end
