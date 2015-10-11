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
				format.html { redirect_to edit_volunteer_path(@volunteer, {tab: "2"}) }
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

	def edit
		@volunteer = Volunteer.find(params[:id])
		@is_show = false
		@is_edit = true
		@fields = [Field.where(is_active: true, tab: 1), Field.where(is_active: true, tab: 2), Field.where(is_active: true, tab: 3)]
	end

	def update
		@volunteer = Volunteer.find(params[:id])
		dyn_attr = @volunteer.dynamic_fields
		if(params.present? && params[:volunteer].present? && params["volunteer"]["dynamic_fields"].present?)
			params[:volunteer][:dynamic_fields].each do |x, y|
				dyn_attr[x] = y
			end
		end
		attributes = volunteer_params
		if(attributes.empty?)
			respond_to do |format|
				format.html { redirect_to success_volunteer_path(@volunteer, {tab: "3"}) }
			end
		else
			attributes["dynamic_fields"] = dyn_attr
			respond_to do |format|
				if @volunteer.update_attributes(attributes)
					if(params[:tab].present? && params[:tab]=="tab2")
						format.html { redirect_to edit_volunteer_path(@volunteer, {tab: "3"}) }
					else
						flash[:success_message] = "Volunteer was successfully updated."
						format.html { redirect_to success_volunteer_path(@volunteer, {tab: "3"}) }
						format.json { render json: @volunteer, status: :created}
					end
				else
					flash[:error] = "Volunteer Update Failed"
					format.html {render action: "new"}
					format.json { render json: @volunteer.errors.full_messages, status: :unprocessable_entity }
				end
			end	
		end
		
	end

	def new
		if(params[:parent_id].present?)
			@parent = Volunteer.find(params[:parent_id])
		else
			@parent = nil
		end
		@volunteer = Volunteer.new
		@fields = [Field.where(is_active: true, tab: 1), Field.where(is_active: true, tab: 2), Field.where(is_active: true, tab: 3)]
		@is_show = false
		@is_edit = false
	end

	def show
		@volunteer = Volunteer.find(params[:id])
		if(@volunteer.social_parent.present?)
			@volunteer.social_parent
		elsif(@volunteer.corporate_parent.present?)
			@parent = @volunteer.corporate_parent
		end
		@fields = [Field.where(is_active: true, tab: 1), Field.where(is_active: true, tab: 2), Field.where(is_active: true, tab: 3)]
		@is_show = true
		@is_edit = false
	end

	private

	def volunteer_params
		params.require(:volunteer).permit! rescue []
	end
	
end