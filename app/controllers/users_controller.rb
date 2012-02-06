class UsersController < ApplicationController
	before_filter :authenticate, :only => [:create, :show, :destroy, :edit]
  	before_filter :admin_user,   :only => [:destroy, :edit]
  
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
  	
  	def destroy_considerations
  		#destroys all considerations posted by a user
  		User.find(params[:id]).considerations.destroy_all
    	redirect_to user_path
  	end
  	
  	def edit
  		@user_to_edit = User.find(params[:id])
  		@user_to_edit.accessible = [:banned] if current_user.admin?
  	end
  	
  	def update
  		@user_to_edit = User.find(params[:id])
  		@user_to_edit.accessible = [:banned] if current_user.admin?
		if @user_to_edit.update_attributes(params[:user])
			flash[:success] = "User banned."
			redirect_to @user_to_edit
		else
			flash[:failure] = "User was not banned."
			render 'edit'
		end
	end
end