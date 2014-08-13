class WebWidgetsController < ApplicationController
	before_filter :current_user

	def main
		if @current_user
			# suggest a size for the given product; get business and product
			business = Business.active.find_by(token: params[:business_id])

			unless business.blank?
				product = business.products.find_by(serial: params[:product_id])

				unless product.blank?
					puts "!!!!!!!!!!!!!!!!!!"
					puts @current_user.bust
					puts @current_user.waist
					puts product.category_id
					# query the business's size chart
					@result = business.sizes.where('category_id = :category and ((min_bust <= :bust and max_bust >= :bust) or (min_waist <= :waist and max_waist >= :waist))', category: product.category_id, bust: @current_user.bust, waist: @current_user.waist).first
				end
			end
		end
	end
end