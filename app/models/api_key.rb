# == Schema Information
#
# Table name: api_keys
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  token      :string(255)
#  expires_at :datetime
#  created_at :datetime
#  updated_at :datetime
#

class ApiKey < ActiveRecord::Base
	belongs_to :user

  before_create :generate_token
  
  scope :active, -> { where("expires_at > ?", Time.now) }

private

  def generate_token
    begin
      self.token = SecureRandom.hex(64)
      self.expires_at = Time.now + Settings.session_length.hours
    end while self.class.exists?(token: token)
  end	
end
