class WebWidgetsController < ApplicationController
	require 'uri' #decode url
	before_filter :current_user

	def main
		puts "A"
		puts @current_user 
		cookies[:original_url] = params[:url]
		cookies[:business_id] = params[:business_id]
		cookies.permanent[:product_id] = params[:product_id]
		if @current_user
			puts "here!!!!!!!!!!"
			# suggest a size for the given product; get business and product
			business = Business.active.find_by(token: params[:business_id])

			unless business.blank?
				product = business.products.find_by(serial: params[:product_id])
				puts "here!!!!!!!!!!"
				unless product.blank?
					# query the business's size chart
					@result = business.sizes.where('category_id = :category and ((min_bust <= :bust and max_bust >= :bust) or (min_waist <= :waist and max_waist >= :waist))', category: product.category_id, bust: @current_user.bust, waist: @current_user.waist).first
				end
			end
		end
	end
end