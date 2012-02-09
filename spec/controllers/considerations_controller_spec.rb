require 'spec_helper'

describe ConsiderationsController do
	render_views
	
	describe "CREATE" do
	
	    before(:each) do 
    		@user = Factory(:user)
    		@consideration = Factory(:consideration, :user => @user)		
    	end
    
    	describe "as a non-signed-in user" do
      		it "should deny access" do
				post :create, :consideration => { :voter_id => @user.id, 
													:content => "Foo bar" }
				response.should be_redirect
			end
			
		    it "should not create a consideration" do
        		lambda do
          			post :create, :consideration => { :content => "Foo bar" }
        		end.should_not change(Consideration, :count).by(1)
      		end
		end
		
		describe "as a regular user" do
		
		    before do 
   				request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
   				visit '/auth/google_oauth2'
   				auth = request.env["omniauth.auth"]
				@user2 = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
				session[:user_id] = @user2.id
			end

      		it "should create a consideration" do
        		lambda do
          			post :create, :consideration => { :content => "Foo bar" }
        		end.should change(Consideration, :count).by(1)
      		end
      	end
      		
      	describe "as a banned user" do
		
		    before do 
   				request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
   				visit '/auth/google_oauth2'
   				auth = request.env["omniauth.auth"]
				@banned = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
				session[:user_id] = @banned.id
				@banned.toggle!(:banned) 
			end

      		it "should create a consideration" do
        		lambda do
          			post :create, :consideration => { :content => "Foo bar" }
        		end.should_not change(Consideration, :count).by(1)
      		end	
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
   				request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
   				visit '/auth/google_oauth2'
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
   				request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
   				visit '/auth/google_oauth2'
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
  	
  	describe "index page" do
  	
  	    before(:each) do 
    		@user = Factory(:user)		
    	end
    
		it "should have an element for each consideration" do
			c1 = Factory(:consideration, :content => Factory.next(:content))
      		c2 = Factory(:consideration, :content => Factory.next(:content))
      		c3 = Factory(:consideration, :content => Factory.next(:content))
      		@considerations = [c1, c2, c3]
        	30.times do
         		@considerations << Factory(:consideration, :content => Factory.next(:content))
			end
        	visit '/index'
        	@considerations[32..33].each do |consideration|
				page.should have_content(consideration.content)
       		end
      	end
      
      	it "should paginate considerations" do
      		c1 = Factory(:consideration, :content => Factory.next(:content))
      		c2 = Factory(:consideration, :content => Factory.next(:content))
      		c3 = Factory(:consideration, :content => Factory.next(:content))
      		@considerations = [c1, c2, c3]
        	40.times do
          		@considerations << Factory(:consideration, :content => Factory.next(:content))
			end
        	visit '/index'
        	page.should have_selector("a", :content => "2")
        	page.should have_selector("a", :content => "Next")
      	end
  	end
end