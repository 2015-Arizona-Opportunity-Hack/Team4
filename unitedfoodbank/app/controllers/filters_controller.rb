class FiltersController < ActionController::Base

	def index
			# @corporates = Volunteer.map do |x| x.type='corporate' or x.type='social'
			@corporates = Volunteer.where(type: 'corporate')
			@socials = Volunteer.where(type: 'social')
	end

  def show
		@volunteers = Volunteer.all
		type = params[:branch]
		corp = params[:corp]
		social = params[:social]
		matcher = {}
		if(params[:date].present?)
			start_date = params[:date].split("-")[0].rstrip
			end_date = params[:date].split("-")[1].lstrip
			matcher = {created_at: {'$gte' =>  Time.parse(start_date).beginning_of_day, '$lte' => Time.parse(end_date).end_of_day}}
		end
		if(type.present?)
			matcher[:type] = type.downcase
		end
		if(corp.present?)
			matcher[:name] = corp
		end
		if(social.present?)
			matcher[:name] = social
		end
		@volunteers = Volunteer.where(matcher)
		json = @volunteers.to_a.to_json
		puts render :json => @volunteers.to_a.to_json
	end
end