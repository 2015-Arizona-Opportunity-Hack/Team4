class HomeController < ActionController::Base

	def index
		@volunteer = Volunteer.new
	end
	def search
		x = Volunteer.where(email: params[:email], phone: params[:phone])
		@volunteer_type = "individual"
		if( x.count == 0) then
			respond_to do |format|
				format.html {redirect_to new_volunteer_path}
			end
		elsif( params[:vol_type] == "2" || params[:vol_type] == "3")
			@volunteer_type = "non_individual"
			@link = x.first.generate_link
		end
	end

	def field_params
		params.require(:volunteer).permit(:phone, :email)
	end

end