# == Schema Information
#
# Table name: sizes
#
#  id          :integer          not null, primary key
#  business_id :integer
#  name        :string(255)
#  min_bust    :decimal(6, 2)
#  max_bust    :decimal(6, 2)
#  min_waist   :decimal(6, 2)
#  max_waist   :decimal(6, 2)
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer
#

class Size < ActiveRecord::Base
	has_many :logs

	belongs_to :business
	belongs_to :category
end
