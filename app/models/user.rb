class User < ActiveRecord::Base
	attr_accessible :name
	has_many :considerations
	has_many :votes,	:foreign_key => "voter_id",
						:dependent => :destroy
	has_many :voteds, :through => :votes, :source => :voted
	
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
	
	def vote!(voted)
		votes.create!(:voted_id => voted.id)
	end
end
