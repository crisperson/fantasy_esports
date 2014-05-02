class League < ActiveRecord::Base
  before_save { self.name = name.downcase }
  before_save { self.tag = tag.downcase } 
   
  validates :name,  presence: true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }

  validates :tag,  presence: true, length: { maximum: 6 },
                      uniqueness: { case_sensitive: false }

  VALID_WEB_REGEX = /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\z/i
  validates :website, format: { with: VALID_WEB_REGEX }

end
