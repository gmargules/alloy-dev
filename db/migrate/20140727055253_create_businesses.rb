class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
    	t.string	:name
    	t.string	:logo
        t.decimal   :lat, { precision: 10, scale: 6 }
    	t.decimal   :lng, { precision: 10, scale: 6 }
    	t.text		:description
    	t.string	:phone  	
    	t.string	:address

    	t.timestamps
    end
  end
end
