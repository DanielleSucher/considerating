class Consideration < ActiveRecord::Base
	attr_accessible :content
	
	belongs_to :user
	has_many :reverse_votes,	:foreign_key => "voted_id",
								:class_name => "Vote",
								:dependent => :destroy
	has_many :voters, :through => :reverse_votes, :source => :voter
	
	default_scope :order => 'considerations.created_at DESC'
	
	validates :user_id, :presence => true
	validates :content, :presence => true, :length => { :maximum => 500 }
	validates_exclusion_of :content, :in => %w( http href ), :message => "No links please!"

	def self.random
       	if self.count != 0
#         	find(:first, :offset => rand(c))
         	count = self.count()
		    self.find(:first, :offset => rand(count))
       	end
	end
end