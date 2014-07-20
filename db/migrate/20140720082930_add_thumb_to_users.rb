class AddThumbToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :thumb, :string
  end
end
