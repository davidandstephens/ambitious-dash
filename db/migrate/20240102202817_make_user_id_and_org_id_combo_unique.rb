class MakeUserIdAndOrgIdComboUnique < ActiveRecord::Migration[7.1]
  def change
    add_index :memberships, :user_id
    add_index :memberships, :organization_id
    add_index :memberships, [:user_id, :organization_id], unique: true
  end
end
