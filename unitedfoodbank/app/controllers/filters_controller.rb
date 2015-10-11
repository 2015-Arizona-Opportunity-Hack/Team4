class FiltersController < ActionController::Base

	def index
	@volunteers = Volunteer.all
	end

  def show
		@volunteers = Volunteer.all
		puts @volunteers.to_s
		json = @volunteers.to_a.to_json
		puts json
		puts render :json => @volunteers.to_a.to_json
	end
end