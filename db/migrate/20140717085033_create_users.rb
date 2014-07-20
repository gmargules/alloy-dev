class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :fb_id
      t.string :first_name
      t.string :last_name
			t.float :bust
			t.float :waist
			t.boolean :is_blocked, default: false
			t.string :reset_password_token
			t.datetime :reset_password_sent_at      
			t.integer :sign_in_count, default: 0
			t.datetime :current_sign_in_at
			t.datetime :last_sign_in_at

      t.timestamps    	
    end
  end
end
