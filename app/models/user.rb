# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  password               :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  bust                   :decimal(6, 2)    default(0.0)
#  waist                  :decimal(6, 2)    default(0.0)
#  is_blocked             :boolean          default(FALSE)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  thumb                  :string(255)
#  auth_type              :integer          default(0)
#  access_token           :string(255)
#

class User < ActiveRecord::Base
	include BCrypt

	has_many :logs
	
	before_create :generate_token
	validates :username, uniqueness: true, :allow_blank => false
	validates :first_name, :last_name, :password, presence: true	

  	mount_uploader :thumb, ThumbUploader
  
  	scope :active, -> { where("is_blocked = ?", false) }

	# auth types
	AUTH_TYPE_PASSWORD = 0
	AUTH_TYPE_FACEBOOK = 1

  	def full_name
    	"#{self.first_name} #{self.last_name}".downcase
  	end
  
  	def display_name
    	"#{self.first_name} #{self.last_name[0]}".downcase    
  	end

	private

	def generate_token
		begin
	    	self.access_token = SecureRandom.hex(21)
	    end while self.class.exists?(access_token: access_token)
	end

	class Entity < Grape::Entity
		expose :id, documentation: { type: 'integer' }  
	    expose :first_name, documentation: { type: 'string', desc: "The user's first name" }
	    expose :last_name, documentation: { type: 'string', desc: "The user's last name" }
	    expose :bust, documentation: { type: 'decimal', desc: "The user's bust size" }
	    expose :waist, documentation: { type: 'decimal', desc: "The user's waist size" }
	end

	class EntityWithToken < Entity
		expose :access_token, documentation: { type: 'string' }
	end   	
end
