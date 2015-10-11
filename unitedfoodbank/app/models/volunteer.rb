class Volunteer
	include Mongoid::Document
	include Mongoid::Timestamps

 	field :phone, type: String
	field :email, type: String
	field :type, type: String
	field :name, type: String
	field :dynamic_fields, type: Hash, default: {} # example: {key: 'address', value: 'fdf'}

	#self-associations
	has_many :corporate_children, :class_name => "Volunteer", :inverse_of => :corporate_parent
	has_many :social_children, :class_name => "Volunteer", :inverse_of => :social_parent
	belongs_to :corporate_parent, :class_name => "Volunteer", :inverse_of => :corporate_children
	belongs_to :social_parent, :class_name => "Volunteer", :inverse_of => :social_children

	validates_uniqueness_of :phone
	validates_uniqueness_of :email

	def generate_link
		link = "http://localhost:3000/volunteers/new?parent_id=#{self.id}"
		return link
	end
end