class AddTokenIndexToApiKeys < ActiveRecord::Migration
  def change
  	add_index :api_keys, :token
  end
end
