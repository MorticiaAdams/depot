class AddEmailToUsers < ActiveRecord::Migration
  def change
    # Disable! Devise will add the email column!  
    #add_column :users, :email, :string, :length => 64
  end
end
