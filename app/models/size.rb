# == Schema Information
#
# Table name: sizes
#
#  id          :integer          not null, primary key
#  business_id :integer
#  name        :string(255)
#  min_bust    :float
#  max_bust    :float
#  min_waist   :float
#  max_waist   :float
#  created_at  :datetime
#  updated_at  :datetime
#

class Size < ActiveRecord::Base
	belongs_to :business
	has_many :logs
end
