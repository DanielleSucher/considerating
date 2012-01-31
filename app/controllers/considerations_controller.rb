class ConsiderationsController < ApplicationController
	before_filter :authenticate, :only => :create
	
  	def create
  		@consideration = current_user.considerations.build(params[:consideration])
  		if @consideration.save
			flash[:success] = "Consideration created!"
			redirect_to root_path
		else
			flash[:failure] = "Sorry, no consideration was created."
			redirect_to root_path
		end
  	end
end