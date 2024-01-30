class AddLabsEmployeeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_labs_employee, :boolean
  end
end
