# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  business_id :integer
#  serial      :string(255)
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer
#

class Product < ActiveRecord::Base
	belongs_to :business
	belongs_to :category
end
