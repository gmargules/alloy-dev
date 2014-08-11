class AddAuthTypeToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :auth_type, :integer, default: 0
  end
end
