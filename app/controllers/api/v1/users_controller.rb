class Api::V1::UsersController < Api::V1::ApiController
	def update
		@current_user.bust = params[:bust] unless params[:bust].blank?
		@current_user.waist = params[:waist] unless params[:waist].blank?
		@current_user.thumb = params[:thumb] unless params[:thumb].blank?

		unless @current_user.save
			save_error
		else
			@user = @current_user
			render :show
		end
	end
end
