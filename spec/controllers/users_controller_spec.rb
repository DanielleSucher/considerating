require 'spec_helper'

describe UsersController do
	render_views
  
  	describe "DELETE 'destroy'" do
    
    	before { @user = Factory(:user) }
    
    	describe "as a non-signed-in user" do
      		it "should deny access" do
        		delete :destroy, :id => @user
        		response.should redirect_to(root_path)
      		end
      		
      		it "should not destroy the user" do
        		lambda do
          			delete :destroy, :id => @user
        		end.should_not change(User, :count).by(-1)
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
        		delete :destroy, :id => @user
        		response.should redirect_to(root_path)
      		end
      		
      		it "should not destroy the user" do
        		lambda do
          			delete :destroy, :id => @user
        		end.should_not change(User, :count).by(-1)
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

      		it "should destroy the user" do
        		lambda do
          			delete :destroy, :id => @user
        		end.should change(User, :count).by(-1)
      		end
      
      		it "should redirect to the root path" do
        		delete :destroy, :id => @user
        		response.should redirect_to(root_path)
      		end
    	end
  	end

  	describe "BAN user" do
    
    	before { @user = Factory(:user) }
    
    	describe "as a non-signed-in user" do
    	
      		it "should deny access" do
        		get :edit, :id => @user
        		response.should redirect_to(root_path)
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
    	
      		it "should deny access" do
        		get :edit, :id => @user
        		response.should redirect_to(root_path)
      		end
      		
      		it "should not ban the user" do
        		put :update, :id => @user, :user => {:banned => true}
        		@user.banned.should == false
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
			
			it "should grant access" do
        		get :edit, :id => @user
        		response.should render_template('edit')
      		end
      		
      		it "should ban the user" do
      			visit edit_user_path(@user)
        		put :update, :id => @user, :user => {:banned => true}
        		@user.reload
        		@user.banned.should == true
      		end
    	end
  	end
end
  