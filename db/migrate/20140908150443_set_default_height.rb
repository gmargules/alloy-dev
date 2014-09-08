class SetDefaultHeight < ActiveRecord::Migration
  def change
 	change_column :users, :height, :float, :default => 0
  end
end
