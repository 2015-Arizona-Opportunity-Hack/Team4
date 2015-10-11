class FiltersController < ActionController::Base

	def index
	@volunteers = Volunteer.all
	end

end