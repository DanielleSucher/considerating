class Vote < ActiveRecord::Base
	attr_accessible :voted_id, :rating
	  
	belongs_to :voter, :class_name => "User"
	belongs_to :voted, :class_name => "Consideration"
	  
	validates :voter_id, :presence => true
	validates :voted_id, :presence => true
	validates :rating, :presence => true
end
