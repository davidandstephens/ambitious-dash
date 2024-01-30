class AddDetailsToOrganizations < ActiveRecord::Migration[7.1]
  def change
    add_column :organizations, :description, :text
    add_column :organizations, :location, :string
  end
end
