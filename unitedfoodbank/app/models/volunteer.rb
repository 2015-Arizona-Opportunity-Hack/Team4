class Volunteer
	include Mongoid::Document
	include Mongoid::Timestamps

 	field :phone, type: String
	field :email, type: String
	field :type, type: String
	field :dynamic_fields, type: Hash, default: {} # example: {key: 'address', value: 'fdf'}

	validates_uniqueness_of :phone
	validates_uniqueness_of :email

	def generate_link
		link = "http://localhost:3000/volunteers/new?parent_id=#{self.id}"
		return link
	end
end