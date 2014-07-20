class AddResetPasswordTokenIndexToUsers < ActiveRecord::Migration
  def change
  	add_index :users, :reset_password_token
  end
end
