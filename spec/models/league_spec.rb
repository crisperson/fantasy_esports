require 'spec_helper'

describe League do

  before { @league = League.new(name: "ESports Entertainment Association", tag: "ESEA", website: "play.esea.net") }

  subject { @league }

  it { should respond_to(:name) }
  it { should respond_to(:tag) }
  it { should respond_to(:website) }

  it { should be_valid }

  describe "with league name is blank" do
    before { @league.name = " " }
    it { should_not be_valid }
  end

  describe "with league tag is blank" do
    before { @league.tag = " " }
    it { should_not be_valid }
  end

  describe "with league name that is too long" do
    before { @league.name = "a" * 51 }
    it { should_not be_valid }
  end  

  describe "with league tag that is too long" do
    before { @league.tag = "a" * 7 }
    it { should_not be_valid }
  end  

  describe "when website format is invalid" do
    it "should be invalid" do
      webs = %w[complexity@complexity.com col 0192309 col210293.213.213123 col-1023-0((2))]
      webs.each do |invalid_web|
        @league.website = invalid_web
        expect(@league).not_to be_valid
      end
    end
  end

  describe "when website format is valid" do
    it "should be valid" do
      webs = %w[http://www.complexity.com www.complexity.com complexity.com complexity.ca 
      	news.complexity.com complexity.com/home complexity.com/home.html]
      webs.each do |valid_web|
        @league.website = valid_web
        expect(@league).to be_valid
      end
    end
  end

  describe "when name is already taken" do
    before do
      league_with_same_name = @league.dup
      league_with_same_name.name = @league.name.upcase
      league_with_same_name.save    
  end
    it { should_not be_valid }
  end

  describe "when tag is already taken" do
    before do
      league_with_same_tag = @league.dup
      league_with_same_tag.tag = @league.tag.upcase
      league_with_same_tag.save    
  end
    it { should_not be_valid }
  end 
end
