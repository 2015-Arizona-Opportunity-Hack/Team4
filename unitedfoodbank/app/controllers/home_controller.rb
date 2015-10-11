class HomeController < ActionController::Base

	def index
		@volunteer = Volunteer.new
	end
	def search
		x = Volunteer.where(email: params[:email], phone: params[:phone])
		if( x.count == 0)
			respond_to do |format|
				format.html {redirect_to new_volunteer_path}
			end
		end
	end

	def field_params
		params.require(:volunteer).permit(:phone, :email)
	end

end