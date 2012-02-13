class Consideration < ActiveRecord::Base
	attr_accessible :content, :votes_total, :votes_count, :votes_attributes, :v1, :v2,
					:v3, :v4, :v5, :v6, :v7, :v8, :v9, :v10
	
	belongs_to :user
	has_many :reverse_votes,	:foreign_key => "voted_id",
								:class_name => "Vote",
								:dependent => :destroy
	has_many :voters, :through => :reverse_votes, :source => :voter
	
	default_scope :order => 'considerations.created_at DESC'
	
	validates :user_id, :presence => true
	validates :content, :presence => true, :length => { :maximum => 500 }
	validates_exclusion_of :content, :in => "href", 
										:message => "No links please!"
	validates_exclusion_of :content, :in => "http", 
										:message => "No links please!"
	validates_exclusion_of :content, :in => "Submit a new consideration here.", 
										:message => "No blank considerations, please!"

# 	removing search for heroku deployment
# 	searchable do
# 		text :content
# 	end
# 	
# 	def search
#     	@search = Consideration.search(:include => [:content]) do
#       		keywords(params[:q])
#     	end
#   	end

	include Tanker
	tankit 'idx' do
    	indexes :content
  	end
  	after_save :update_tank_indexes
  	after_destroy :delete_tank_indexes


	def self.random
       	if self.count != 0
#         	find(:first, :offset => rand(c))
         	count = self.count()
		    self.find(:first, :offset => rand(count))
       	end
	end
	
	def add_vote(rating)
		Consideration.increment_counter(:votes_count, id)
		rounded = rating.to_d.round
		Consideration.increment_counter("v#{rounded}".to_sym, id)
		self.votes_total += rating
		self.save
	end
	
	def results
		self.votes_total/self.votes_count
	end
	
	def highest
  		array = [self.v1, self.v2,
  				  self.v3, self.v4, 
  				  self.v5, self.v6, 
  				  self.v7, self.v8, 
  				  self.v9, self.v10]
  		array.max
  	end
end