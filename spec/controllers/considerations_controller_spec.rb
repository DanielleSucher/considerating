require 'spec_helper'

describe ConsiderationsController do
	render_views
	
	describe "access control" do
	
		it "should deny access to 'create'" do
			post :create
			response.should redirect_to(root_path)
		end
	end
	
	describe "DELETE 'destroy'" do
    
    	before(:each) do 
    		@user = Factory(:user)
    		@consideration = Factory(:consideration, :user => @user)		
    	end
    
    	describe "as a non-signed-in user" do
      		it "should deny access" do
        		delete :destroy, :id => @consideration
        		response.should redirect_to(root_path)
      		end
      		
      		it "should not destroy the consideration" do
        		lambda do
          			delete :destroy, :id => @consideration
        		end.should_not change(Consideration, :count).by(-1)
      		end
    	end

    	describe "as a non-admin user" do
    	
    		before do 
   				request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
   				visit '/auth/twitter'
   				auth = request.env["omniauth.auth"]
				user2 = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
				session[:user_id] = user2.id
			end
    	
      		it "should protect the page" do
        		delete :destroy, :id => @consideration
        		response.should redirect_to(root_path)
      		end
      		
      		it "should not destroy the consideration" do
        		lambda do
          			delete :destroy, :id => @consideration
        		end.should_not change(Consideration, :count).by(-1)
      		end
    	end
    
    	describe "as an admin user" do
      
    		before do 
   				request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
   				visit '/auth/twitter'
   				auth = request.env["omniauth.auth"]
				admin = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
				session[:user_id] = admin.id
  				admin.toggle!(:admin) 
			end

      		it "should destroy the consideration" do
        		lambda do
          			delete :destroy, :id => @consideration
        		end.should change(Consideration, :count).by(-1)
      		end
      
      		it "should redirect to the root path" do
        		delete :destroy, :id => @consideration
        		response.should redirect_to(root_path)
      		end
    	end
  	end
end