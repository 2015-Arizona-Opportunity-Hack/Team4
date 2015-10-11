class VolunteersController < ActionController::Base
	layout 'volunteers', :except => [:new, :success]
	layout 'volunteers_new', :only => [:new, :success]

	def index
		@volunteers = (Volunteer.all).paginate(page: params[:page], per_page: 5)
	end

	def create
		@volunteer = Volunteer.new(volunteer_params)
		respond_to do |format|
			if @volunteer.save
				flash[:success_message] = "Volunteer was successfully created."
				format.html { redirect_to success_volunteer_path(@volunteer) }
				format.json { render json: @volunteer, status: :created}
			else
				flash[:error] = "Volunteer already present"
				format.html {render action: "new"}
				format.json { render json: @volunteer.errors.full_messages, status: :unprocessable_entity }
			end
		end
	end

	def success
		x = Volunteer.find(params[:id])
		@volunteer_type = "individual"
		if( x.type == "corporate" || x.type == "social")
			@volunteer_type = "non_individual"
			@link = x.generate_link
		end
	end

	def new
		if(params[:parent_id].present?)
			@parent = Volunteer.find(params[:parent_id])
		else
			@parent = nil
		end
		@volunteer = Volunteer.new
		@fields = Field.where(is_active: true)
		@is_show = false
	end

	def show
		@volunteer = Volunteer.find(params[:id])
		@fields = Field.where(is_active: true)
		@is_show = true
	end

	private

	def volunteer_params
		params.require(:volunteer).permit!
	end
	
end