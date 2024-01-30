class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_create :default_setting
  has_many :owned_organizations, class_name: "Organization", dependent: :destroy, :inverse_of => :owner
  has_many :memberships
  has_many :organizations, through: :memberships

  def default_setting
   self.is_labs_employee ||= false
   self.beta_access ||= false   
  end
end
