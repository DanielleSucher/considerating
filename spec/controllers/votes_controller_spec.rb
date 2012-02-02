require 'spec_helper'

describe VotesController do
	render_views
	
	describe "access control" do

    	it "should require signin for create" do
     		post :create
      		response.should redirect_to(root_path)
    	end
  	end

  	describe "create vote" do
  
      	before(:each) do
   			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
   			visit '/auth/twitter'
   			auth = request.env["omniauth.auth"]
			@user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
			session[:user_id] = @user.id
      		@voted = Factory(:consideration)
    	end

    	it "should create a vote" do
      		lambda do
        		post :create, :vote => { :voted_id => @voted,:rating => 1 }
        		response.should be_redirect
      		end.should change(Vote, :count).by(1)
    	end
  
    	it "should create a vote using Ajax" do
      		lambda do
        		xhr :post, :create, :vote => { :voted_id => @voted,:rating => 1 }
        		response.should be_success
      		end.should change(Vote, :count).by(1)
    	end 
  	end
end