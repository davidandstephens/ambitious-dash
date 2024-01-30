class CreateMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :memberships do |t|
      t.integer :organization_id
      t.integer :user_id
      t.boolean :approved
      t.boolean :rejected

      t.timestamps
    end
  end
end
