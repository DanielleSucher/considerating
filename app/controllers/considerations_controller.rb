class ConsiderationsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :admin_user,   :only => [:destroy, :all]
	  	
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
  	
  	def destroy
    	Consideration.find(params[:id]).destroy
    	flash[:success] = "Consideration destroyed."
    	redirect_to root_path
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
  	
  	def all
  		if Consideration.count != nil
  			@all_considerations = Consideration.paginate(:page => params[:page], :per_page => 2)
		end
  	end
end