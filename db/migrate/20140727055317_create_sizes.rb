class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
    	t.integer	:business_id
    	t.string	:name
    	t.decimal	:min_bust, { precision: 6, scale: 2 }
    	t.decimal	:max_bust, { precision: 6, scale: 2 }
    	t.decimal	:min_waist, { precision: 6, scale: 2 }
    	t.decimal	:max_waist, { precision: 6, scale: 2 }

    	t.timestamps
    end
  end
end
