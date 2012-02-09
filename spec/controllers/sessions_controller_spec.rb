require 'spec_helper'

describe SessionsController do
	render_views
	
	describe "POST 'create'" do
	
		before do 
  			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2] 
  			@user = OmniAuth.config.add_mock(:google_oauth2, {:uid => '12345'})
		end
		
		it "should have a sign out link" do
			post :create, :session => @user
			response.should have_selector("html", :content => "Sign out")
		end
	end
	
	describe "DELETE 'destroy'" do
	
		before do 
  			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2] 
  			@user = OmniAuth.config.add_mock(:google_oauth2, {:uid => '12345'})
		end
		
		it "should sign a user out" do
			delete :destroy
			session[@user.uid].should be_nil
			response.should have_selector("html", :content => "Sign in")
		end
	end
end
