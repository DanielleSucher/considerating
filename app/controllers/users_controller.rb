class UsersController < ApplicationController
	before_filter :authenticate, :only [:create, :show, :destroy]
	
  	def show
    	@user = User.find(params[:id])
  	end

end