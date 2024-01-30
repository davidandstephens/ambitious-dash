class Membership < ApplicationRecord
  before_create :default_setting
  belongs_to :user
  belongs_to :organization
  
  def default_setting
   self.approved ||= false
   self.rejected ||= false   
  end
end
