class AddOwnersToOrganizations < ActiveRecord::Migration[7.1]
  def change
    add_column(:organizations, :owner_id, :integer)
    add_index(:organizations, :owner_id)
  end
end
