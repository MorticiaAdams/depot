class RemoveDetailsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :activated, :boolean
  end
end
