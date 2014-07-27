# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  password_hash          :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  bust                   :float            default(0.0)
#  waist                  :float            default(0.0)
#  is_blocked             :boolean          default(FALSE)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  thumb                  :string(255)
#

class User < ActiveRecord::Base
	include BCrypt
	
	has_many :api_keys
	has_many :logs

	validates :email, uniqueness: true, :allow_blank => true
  
  scope :active, -> { where("is_blocked = ?", false) }
  
  mount_uploader :thumb, ThumbUploader

	def password
		@password ||= Password.new(password_hash)
	end

	def password=(new_password)
		@password = Password.create(new_password)
		self.password_hash = @password
	end

  def full_name
    "#{self.first_name} #{self.last_name}".downcase
  end
  
  def display_name
    "#{self.first_name} #{self.last_name[0]}".downcase    
  end
end
