class Player < ActiveRecord::Base
  before_save { self.aka = aka.downcase }
  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_AKA_REGEX = /\A[\w\-]+\z/i
  validates :aka,  presence: true, 
                    format: { with: VALID_AKA_REGEX },
                    length: { maximum: 25 },
                    uniqueness: { case_sensitive: false }

  validates :cost, :format => { :with => /\A\d+??(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than_or_equal_to => 0.01, :less_than => 20}	

end
