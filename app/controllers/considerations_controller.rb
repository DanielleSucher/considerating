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
  	
  	def show
  		@consideration = Consideration.find(params[:id])
  		if signed_in?
  			@new_consideration = Consideration.new
  		end
  	end
  	
  	def index
  		@search = Consideration.search do
    		fulltext params[:search]
  		end
  		@search_results = @search.results
  	end
end