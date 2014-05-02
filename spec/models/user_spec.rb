require 'spec_helper'

describe User do

  before { @user = User.new(name: "Example User", aka: "trips", email: "user@example.com",
  								password: "foobar",password_confirmation:"foobar") }
  
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:fantasy_teams) }
  it { should respond_to(:feed) }

  it { should be_valid }
  it { should_not be_admin }
  
  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when aka is not present" do
    before { @user.aka = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when alias is too long" do
    before { @user.aka = "a" * 26 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when aka format is invalid" do
    it "should be invalid" do
      akas = %w[trips@trips trips.trips trips+trips tripsy_21asdl() trips\ trips]
      akas.each do |invalid_aka|
        @user.aka = invalid_aka
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when aka format is valid" do
    it "should be valid" do
      akas = %w[trips tr1ps trips-ington trips_ington trips_ trips- TRIPS_ALL_DAY trips_ALL_DAY_219301923]
      akas.each do |valid_aka|
        @user.aka = valid_aka
        expect(@user).to be_valid
      end
    end
  end  

  describe "when aka is already taken" do
    before do
      user_with_same_aka = @user.dup
  	  user_with_same_aka.aka = @user.aka.upcase
      user_with_same_aka.save
    end

    it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "fantasy team associations" do

    before { @user.save }
    let!(:older_team) do
      FactoryGirl.create(:fantasy_team, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_team) do
      FactoryGirl.create(:fantasy_team, user: @user, created_at: 1.hour.ago)
    end

    describe "status" do
      let(:other_user_team) do
        FactoryGirl.create(:fantasy_team, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_team) }
      its(:feed) { should include(older_team) }
      its(:feed) { should_not include(other_user_team) }
    end

    it "should have the right fantasy team in the right order" do
      expect(@user.fantasy_teams.to_a).to eq [newer_team, older_team]
    end

    it "should destroy associated fantasy teams" do
      fantasy_teams = @user.fantasy_teams.to_a
      @user.destroy
      expect(fantasy_teams).not_to be_empty
      fantasy_teams.each do |fantasy_team|
        expect(FantasyTeam.where(id: fantasy_team.id)).to be_empty
      end
    end    
  end  
end