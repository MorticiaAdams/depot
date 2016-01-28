class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :row_id, :integer
  end
end
