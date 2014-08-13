class RefactorProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :thumb
  	remove_column :products, :description
  	remove_column :products, :price
  end
end
