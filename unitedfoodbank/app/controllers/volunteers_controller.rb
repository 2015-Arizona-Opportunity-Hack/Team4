class VolunteersController < ActionController::Base

	def index
		@volunteers = (Volunteer.all).paginate(page: params[:page], per_page: 5)
	end

	def edit
	end

	def new
	end
	
end