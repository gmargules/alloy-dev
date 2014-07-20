class SetDefaultWaistAndBust < ActiveRecord::Migration
  def change
 	change_column :users, :waist, :float, :default => 0
 	change_column :users, :bust, :float, :default => 0
  end
end
