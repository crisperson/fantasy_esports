class Team < ActiveRecord::Base
  before_save { self.tag = tag.downcase }
  before_save { self.name = name.downcase }
  
  default_scope -> { order('name DESC') }

  VALID_NAME_REGEX = /\A[\w\-\_\+\ \^\.]+\z/i
  validates :name,  presence: true, 
  					length: { maximum: 50 }, 
  					format: { with: VALID_NAME_REGEX },
  					uniqueness: {case_sensitive: false }
  
  validates :tag,  presence: true, 
                    length: { maximum: 15 },
                    uniqueness: { case_sensitive: false }

  VALID_WEB_REGEX = /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\z/i
  validates :website, format: { with: VALID_WEB_REGEX }

end
