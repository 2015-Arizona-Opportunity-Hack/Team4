class FieldsController < ActionController::Base

	def index
		@fields = Field.all
	end

	def edit
		@field = Field.find(params[:id])
	end

	def new
		@field = Field.new
	end

	def update
		@field = Field.find(params[:id])
		respond_to do |format|
			if @field.update_attributes(field_params)
				flash[:success_message] = "Field was successfully updated."
				format.html { redirect_to fields_path}
			else
				format.html { render action: "new" }
			end
		end
	end

	def create
		@field = Field.new(field_params)
		respond_to do |format|
			if @field.save
				flash[:success_message] = "Field was successfully created."
				format.html { redirect_to fields_path}
				format.json { render json: @field, status: :created}
			else
				format.html { render action: "new" }
				format.json { render json: @field.errors.full_messages, status: :unprocessable_entity }
			end
		end
	end

	private

	def field_params
		params.require(:field).permit(:name, :type, :required, :tab, :is_active, :include_in_individual, :include_in_corporate, :include_in_social)
	end
	
end