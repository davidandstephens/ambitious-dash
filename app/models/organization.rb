class Organization < ApplicationRecord
  belongs_to :owner, class_name: "User", :inverse_of => :owned_organizations
  has_many :memberships
  has_many :users, through: :memberships
end
