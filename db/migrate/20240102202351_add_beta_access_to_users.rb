class AddBetaAccessToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :beta_access, :boolean
  end
end
