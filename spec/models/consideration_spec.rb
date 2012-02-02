require 'spec_helper'

describe Consideration do
  
	before {
  		@user = Factory(:user)
		@attr = { :content => "value for content" }
	}
	
	describe "create" do
		it "should create a new instance given valid attributes" do
			@user.considerations.create!(@attr)
		end
	end
	
	describe "user associations" do
	
		before { @consideration = @user.considerations.create(@attr) }
		
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
			@user.vote!(@voted, 6.24)
			@voted.voters.should include(@user)
		end
	end
	
	describe "vote totals and counts" do
		before { @consideration = Factory(:consideration) }
	
		it "should have a votes_total method" do
			@consideration.should respond_to(:votes_total)
		end
		
		it "should have a votes_count method" do
			@consideration.should respond_to(:votes_count)
		end
		
		it "should have the right votes_count" do
			lambda do
				@user.vote!(@consideration, 3.7)
#			@consideration.votes_count.should == @consideration.voters.count
			end.should change(@consideration.voters, :count).by(1)
		end
	end
	
	describe "searching", :search => true do
		before { @consideration = Factory(:consideration) }
	
		it "should have a search method" do
			@consideration.should respond_to(:search)
		end
		
		it 'should return consideration search results' do
      		searchable_post = Factory(:consideration, :content => "Of Mice and Men")
      		Sunspot.commit
      		Consideration.search { keywords "mice"}.results.should == [searchable_post]
    	end
	end
end