class VolunteersController < ActionController::Base
	layout 'volunteers', :except => :new
	layout 'volunteers_new', :only => :new

	def index
		@volunteers = (Volunteer.all).paginate(page: params[:page], per_page: 5)
	end

	def create
		@volunteer = Volunteer.new(volunteer_params)
		respond_to do |format|
			if @volunteer.save
				flash[:success_message] = "Field was successfully created."
				format.html { redirect_to volunteers_path}
				format.json { render json: @volunteer, status: :created}
			else
				format.html { render action: "new" }
				format.json { render json: @volunteer.errors.full_messages, status: :unprocessable_entity }
			end
		end
	end

	def new
		@volunteer = Volunteer.new
		@fields = Field.where(is_active: true)
	end

	private

	def volunteer_params
		params.require(:volunteer).permit(:email, :phone, :dynamic_fields)
	end
	
end