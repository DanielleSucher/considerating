require 'spec_helper'

describe User do
  	before { 
  		@user = Factory(:user)
  		@c1 = Factory(:consideration, :user => @user, :created_at => 1.day.ago)
  		@c2 = Factory(:consideration, :user => @user, :created_at => 1.day.ago)
	}

  	subject { @user }

  	it { should respond_to(:name) }
  
  	describe "consideration associations" do
  		
  		it "should have a considerations attribute" do
  			@user.should respond_to(:considerations)
  		end
  		
  		it "should have the right considerations in the right order" do
  			@user.considerations.should == [@c2, @c1]
  		end
  	end
  	
  	describe "validations" do
	
		it "should require a name" do
			@attr = { :name => "Example User" }
			no_name_user = User.new(@attr.merge(:name => ""))
			no_name_user.should_not be_valid
		end
	end
	
	describe "votes" do
	
		before { @voted = Factory(:consideration) }
		
		it "should have a votes method" do
			@user.should respond_to(:votes)
		end
		
		it "should have a voteds method" do
			@user.should respond_to(:voteds) 
		end
		
		it "should vote on a consideration" do
			@user.vote!(@voted)
			@user.should be_voteds(@voted)
		end
		
		it "should include the voted consideration in the voteds array" do
			@user.vote!(@voted)
			@user.voteds.should include(@voted)
		end
	end
end
