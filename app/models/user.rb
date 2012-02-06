class User < ActiveRecord::Base
	attr_accessor :accessible
	attr_accessible :name, :votes_attributes, :considerations_attributes
	has_many :considerations
	has_many :votes,	:foreign_key => "voter_id"
	has_many :voteds, :through => :votes, :source => :voted
	
# 	accepts_nested_attributes_for :votes
# 	accepts_nested_attributes_for :considerations, :reject_if => lambda { |a| a[:rating].blank? }
	
	validates :name, :presence => true

	def self.create_with_omniauth(auth)
		create! do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.name = auth["info"]["name"]
		end
	end
	
	def voteds?(voted)
		votes.find_by_voted_id(voted)
	end
	
	def vote!(voted, rating)
		votes.create!(:voted_id => voted.id, :rating => rating)
		current_vote = votes.find_by_voted_id(voted)
		considered = Consideration.find_by_id(voted.id)
		considered.add_vote(current_vote)
	end
	
	private
	
		def mass_assignment_authorizer(role = :default)
    		super + (accessible || [])
  		end
end
