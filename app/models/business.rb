# == Schema Information
#
# Table name: businesses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  logo        :string(255)
#  lat         :decimal(10, 6)
#  lng         :decimal(10, 6)
#  description :text
#  phone       :string(255)
#  address     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  is_blocked  :boolean          default(FALSE)
#  token       :string(255)
#

class Business < ActiveRecord::Base
  has_many :logs
	has_many :products, dependent: :destroy

  scope :active, -> { where("is_blocked = ?", false) }	

  validates :token, uniqueness: true, :allow_blank => false

  before_create :generate_token

private

  def generate_token
    begin
      self.token = SecureRandom.hex(21)
    end while self.class.exists?(token: token)
  end	  
end
