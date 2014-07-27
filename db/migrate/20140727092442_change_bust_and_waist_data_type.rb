class ChangeBustAndWaistDataType < ActiveRecord::Migration
  def change
  	change_column :users, :bust, :decimal, { precision: 6, scale: 2 }
  	change_column :users, :waist, :decimal, { precision: 6, scale: 2 }
  end
end
