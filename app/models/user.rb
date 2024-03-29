class User < ActiveRecord::Base
  has_many :fantasy_teams, dependent: :destroy
  before_save { self.email = email.downcase }
  before_save { self.aka = aka.downcase }  
  before_create :create_remember_token
  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_AKA_REGEX = /\A[\w\-]+\z/i
  validates :aka,  presence: true, 
                    format: { with: VALID_AKA_REGEX },
                    length: { maximum: 25 },
                    uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  					        format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password          
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    FantasyTeam.where("user_id = ?", id)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end