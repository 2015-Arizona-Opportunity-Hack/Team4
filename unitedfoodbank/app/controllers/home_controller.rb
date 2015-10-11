class HomeController < ActionController::Base

	def index
		@volunteer = Volunteer.new
	end
	def search

		# Get the params as local variables
		#iemail = [params[:email]]
		#iphone = [params[:phone]]

		x = Volunteer.where(email: params[:email], phone: params[:phone])

		puts x.count

		if( x.count == 0)
			puts "================= No data Present++++++++++++++++++++++++"
			respond_to do |format|
			format.html {redirect_to new_volunteer}
			end

		end

		# search through the volunteer db using email and phone number

		# if present show the search.html.erb
		#send email confirmation
		# else redirect to volunteers.new registration link

	end

	def field_params
		params.require(:volunteer).permit(:phone, :email)
	end

end