class RemoveRowIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :row_id, :integer
  end
end
