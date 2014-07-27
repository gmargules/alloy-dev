# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  business_id :integer
#  serial      :string(255)
#  name        :string(255)
#  thumb       :string(255)
#  description :text
#  price       :float
#  created_at  :datetime
#  updated_at  :datetime
#

class Product < ActiveRecord::Base
	belongs_to :business
end
