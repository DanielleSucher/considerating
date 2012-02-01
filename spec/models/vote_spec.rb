require 'spec_helper'

describe Vote do	
	before {
  		@voter = Factory(:user)
  		@voted = Factory(:consideration)
  		
  		@vote = @voter.votes.build(:voted_id => @voter.id)
  	}
  	
  	it "should create a new instance given valid attributes" do
  		@vote.save!
  	end
  	
  	describe "vote methods" do
  	
  		before {
  			@vote.save
  		}
  		
  		it "should have a voter attribute" do
  			@vote.should respond_to(:voter)
  		end
  		
  		it "should have the right voter" do
  			@vote.voter.should == @voter
  		end
  		
  		it "should have a voted attribute" do
  			@vote.should respond_to(:voted)
  		end
  		
  		it "should have the right voted" do
  			@vote.voted.should == @voted
  		end
  	end
  	
  	describe "validations" do
  	
  		it "should require a voter_id" do
  			@vote.voter_id = nil
  			@vote.should_not be_valid
  		end
  		
  		it "should require a voted_id" do
  			@vote.voted_id = nil
  			@vote.should_not be_valid
  		end
  	end
end
