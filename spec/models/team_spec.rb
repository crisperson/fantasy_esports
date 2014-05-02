require 'spec_helper'

describe Team do

  #note: leader should be a foreign key to the player db probably
  before { @team = Team.new(name: "complexity", tag: "coL", leader: "seangares", 
  								website: "complexity.com") }
  
  subject { @team }


  it { should respond_to(:name) }
  it { should respond_to(:tag) }
  it { should respond_to(:leader) }
  it { should respond_to(:website) }
 
  it { should be_valid }

  describe "when name is not present" do
    before { @team.name = " " }
    it { should_not be_valid }
  end

  describe "when tag is not present" do
    before { @team.tag = " " }
    it { should_not be_valid }
  end

  describe "when tag is too long" do
    before { @team.tag = "a" * 16 }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @team.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when website format is invalid" do
    it "should be invalid" do
      webs = %w[complexity@complexity.com col 0192309 col210293.213.213123 col-1023-0((2))]
      webs.each do |invalid_web|
        @team.website = invalid_web
        expect(@team).not_to be_valid
      end
    end
  end

  describe "when website format is valid" do
    it "should be valid" do
      webs = %w[http://www.complexity.com www.complexity.com complexity.com complexity.ca 
      	news.complexity.com complexity.com/home complexity.com/home.html]
      webs.each do |valid_web|
        @team.website = valid_web
        expect(@team).to be_valid
      end
    end
  end 

  describe "when name format is invalid" do
    it "should be invalid" do
      names = %w[&283678adlaksd team#name for=team=name]
      names.each do |invalid_name|
        @team.name = invalid_name
        expect(@team).not_to be_valid
      end
    end
  end

  describe "when name format is valid" do
    it "should be valid" do
      names = %w[complexity complexity-ca reliable.ca reliable^canada reliable_canada reliable12canada reliable\ canada]
      names.each do |valid_name|
        @team.name = valid_name
        expect(@team).to be_valid
      end
    end
  end 

  describe "when name is already taken" do
    before do
      team_with_same_name = @team.dup
      team_with_same_name.name = @team.name.upcase
      team_with_same_name.save    
  end
    it { should_not be_valid }
  end

  describe "when tag is already taken" do
    before do
      team_with_same_tag = @team.dup
      team_with_same_tag.tag = @team.tag.upcase
      team_with_same_tag.save    
  end
    it { should_not be_valid }
  end

end
