class RemoveLockedFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :locked, :boolean
  end
end
