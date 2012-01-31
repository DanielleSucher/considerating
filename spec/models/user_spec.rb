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
end
