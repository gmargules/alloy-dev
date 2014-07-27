# == Schema Information
#
# Table name: logs
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  business_id :integer
#  size_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Log < ActiveRecord::Base
	belongs_to :user
	belongs_to :business
	belongs_to :size
end
