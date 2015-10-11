class Volunteer
	include Mongoid::Document
	include Mongoid::Timestamps

 	field :phone, type: String
	field :email, type: String
	field :dynamic_fields, type: Hash, default: {} # example: {key: 'address', value: 'fdf'}

end