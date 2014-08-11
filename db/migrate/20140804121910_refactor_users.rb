class RefactorUsers < ActiveRecord::Migration
  def up
  	rename_column :users, :email, :username
  	rename_column :users, :password_hash, :password
  end

  def down
  end
end
