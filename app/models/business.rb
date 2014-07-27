# == Schema Information
#
# Table name: businesses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  logo        :string(255)
#  lat         :float
#  lng         :float
#  description :text
#  phone       :string(255)
#  address     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  is_blocked  :boolean          default(FALSE)
#

class Business < ActiveRecord::Base
	has_many :products
	has_many :logs

  scope :active, -> { where("is_blocked = ?", false) }	
end
