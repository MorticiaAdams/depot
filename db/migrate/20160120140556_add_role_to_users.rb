class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, limit: 12
  end
end
