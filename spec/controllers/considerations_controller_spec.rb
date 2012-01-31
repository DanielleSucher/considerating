require 'spec_helper'

describe ConsiderationsController do
	render_views
	
	describe "access control" do
	
		it "should deny access to 'create'" do
			post :create
			response.should redirect_to(root_path)
		end
	end
end