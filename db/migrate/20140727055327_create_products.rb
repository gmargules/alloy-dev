class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.integer		:business_id
    	t.string		:serial
    	t.string		:name
    	t.string		:thumb
    	t.text			:description
    	t.decimal		:price, { precision: 10, scale: 2 }

    	t.timestamps
    end
  end
end
