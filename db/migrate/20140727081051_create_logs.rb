class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
    	t.integer		:user_id
    	t.integer		:business_id
    	t.integer		:size_id

    	t.timestamps
    end
  end
end
