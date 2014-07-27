class AddIsBlockedToBusinesses < ActiveRecord::Migration
  def change
  	add_column :businesses, :is_blocked, :boolean, default: :false
  end
end
