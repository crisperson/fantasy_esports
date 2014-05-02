require 'spec_helper'

describe Player do

  before { @player = Player.new(name: "Example Player", aka: "trips", age: 17,
  								location: "Ontario, Canada",cost:18.38) }
  
  subject { @player }


  it { should respond_to(:name) }
  it { should respond_to(:aka) }
  it { should respond_to(:cost) }
  it { should respond_to(:age) }
  it { should respond_to(:location) }

  it { should be_valid }

  describe "when name is not present" do
    before { @player.name = " " }
    it { should_not be_valid }
  end

  describe "when aka is not present" do
    before { @player.aka = " " }
    it { should_not be_valid }
  end

  describe "when cost is not present" do
    before { @player.cost = " " }
    it { should_not be_valid }
  end  

  describe "when aka is too long" do
    before { @player.aka = "a" * 26 }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @player.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when aka format is invalid" do
    it "should be invalid" do
      akas = %w[trips@trips trips.trips trips+trips tripsy_21asdl() trips\ trips]
      akas.each do |invalid_aka|
        @player.aka = invalid_aka
        expect(@player).not_to be_valid
      end
    end
  end

  describe "when aka format is valid" do
    it "should be valid" do
      akas = %w[trips tr1ps trips-ington trips_ington trips_ trips- TRIPS_ALL_DAY trips_ALL_DAY_219301923]
      akas.each do |valid_aka|
        @player.aka = valid_aka
        expect(@player).to be_valid
      end
    end
  end 

  describe "when cost format is invalid" do
    it "should be invalid" do
      costs = %w[20.01 -0.43 188.38381 18181818 aesad]
      costs.each do |invalid_cost|
        @player.cost = invalid_cost
        expect(@player).not_to be_valid
      end
    end
  end

  describe "when aka format is valid" do
    it "should be valid" do
      costs = %w[17.34 0.01 4.83 9.99 19.99]
      costs.each do |valid_cost|
        @player.cost = valid_cost
        expect(@player).to be_valid
      end
    end
  end 

  describe "when aka is already taken" do
    before do
      player_with_same_aka = @player.dup
      player_with_same_aka.aka = @player.aka.upcase
      player_with_same_aka.save    
  end

    it { should_not be_valid }
  end

end
