require 'spec_helper'

describe Consideration do
  
	before(:each) do
  		@user = Factory(:user)
		@attr = { :content => "value for content" }
	end
	
	it "should create a new instance given valid attributes" do
		@user.considerations.create!(@attr)
	end
	
	describe "user associations" do
	
		before(:each) do
			@consideration = @user.considerations.create(@attr)
		end
		
		it "should have a user attribute" do
			@consideration.should respond_to(:user)
		end
		
		it "should have the right associated user" do
			@consideration.user_id.should == @user.id
			@consideration.user.should == @user
		end
	end
	
	describe "validations" do
	
		it "should require a user id" do
			Consideration.new(@attr).should_not be_valid
		end
		
		it "should require nonblank content" do
			@user.considerations.build(:content => "   ").should_not be_valid
		end
		
		it "should reject content containing links" do
			@user.considerations.build(:content => "href").should_not be_valid
		end
		
		it "should reject long content" do
			@user.considerations.build(:content => "a" * 501).should_not be_valid
		end
	end
	
	describe "votes" do
		before { @voted = Factory(:consideration) }
		
		it "should have a reverse_votes method" do
			@voted.should respond_to(:reverse_votes)
		end
		
		it "should have a voters method" do
			@voted.should respond_to(:voters)
		end
		
		it "should include the voter in the voters array" do
			@user.vote!(@voted)
			@voted.voters.should include(@user)
		end
	end
end