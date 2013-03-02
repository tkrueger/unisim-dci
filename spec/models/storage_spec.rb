require 'spec_helper'

describe Storage do

  before :each do
    @ore = Product.new "ore", 4
    @silicon = Product.new "silicon", 1
  end

  it "has a capacity" do
    storage = Storage.new 100
    storage.capacity.should == 100
  end

  it "returns empty amount when asked for contents not present" do
    storage = Storage.new 100
    storage.content(@ore).should == Amount.new(@ore, 0)
  end

  describe 'checking available space' do
    it 'works on an empty storage' do
      storage = Storage.new 10
      storage.has_room_for?(1.units_of @ore).should == true
      storage.has_room_for?(3.units_of @ore).should == false
    end

    it 'works on a filled storage' do
      storage = Storage.new 100
      storage.store 99.units_of @silicon
      storage.has_room_for?(2.units_of @silicon).should == false
    end
  end

  describe "storing product amounts" do

    before :each do
      @storage = Storage.new 100
      @amount = Amount.new  @ore, 2
      @storage.store @amount
    end

    it "puts them in the storage" do
      @storage.content(@ore).should == 2.units_of(@ore)
    end

    it "counts against free capacity" do
      @storage.free_space.should == 100 - @amount.required_storage_space
    end

  end

  describe "storing multiple products" do
    before :each do
      @storage = Storage.new 100
      @amount_of_ore = 2.units_of @ore
      @amount_of_silicon = 2.units_of @silicon
      @storage.store @amount_of_ore
      @storage.store @amount_of_silicon
    end

    it "puts them in the storage" do
      @storage.content(@ore).nr_of_units.should == 2
      @storage.content(@silicon).nr_of_units.should == 2
    end

    it "counts against free capacity" do
      @storage.free_space.should == (100 - @amount_of_ore.required_storage_space - @amount_of_silicon.required_storage_space)
    end

  end

  describe "retrieving from storage" do
    before :each do
      @storage = Storage.new 100
      @storage.store 10.units_of @silicon
    end

    it "is only possible for stuff that's in" do
      expect { @storage.retrieve 10.units_of @ore }.to raise_error
      @storage.retrieve 4.units_of @silicon
      @storage.content(@silicon).should eq(6.units_of @silicon)
    end

  end
end
