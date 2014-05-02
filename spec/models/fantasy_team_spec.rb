require 'spec_helper'

describe FantasyTeam do

  let(:user) { FactoryGirl.create(:user) }
  before { @fantasyteam = user.fantasy_teams.build(tname: "Lorem ipsum") }

  subject { @fantasyteam }

  it { should respond_to(:tname) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @fantasyteam.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank team name" do
    before { @fantasyteam.tname = " " }
    it { should_not be_valid }
  end

  describe "with team name that is too long" do
    before { @fantasyteam.tname = "a" * 51 }
    it { should_not be_valid }
  end  
end