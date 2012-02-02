class UsersController < ApplicationController
	before_filter :authenticate, :only => [:create, :show, :destroy]
  	before_filter :admin_user,   :only => :destroy
  
  	def show
    	@user_to_show = User.find(params[:id])
    	@user_considerations = @user_to_show.considerations.all
    	@new_consideration = Consideration.new if signed_in?
  	end

  	def destroy
    	User.find(params[:id]).destroy
    	flash[:success] = "User destroyed."
    	redirect_to root_path
  	end
end