class ConsiderationsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :admin_user,   :only => :destroy
	before_filter :no_banned_users,   :only => [:create, :destroy]
	before_filter :limit_anonymous_voting 
	  	
  	def create
  		@consideration = current_user.considerations.build(params[:consideration])
  		if @consideration.save
			flash[:success] = "Consideration created!"
			redirect_to user_path(current_user)
		end
  	end
  	
  	def destroy
    	Consideration.find(params[:id]).destroy
    	flash[:success] = "Consideration destroyed."
    	respond_to do |format|  
    		format.html { redirect_to root_path }  
    		format.js 
  		end  
  	end
  	
  	  def update
		@consideration = Consideration.find(params[:id])
		rating = params[:rating].to_d/10
		if rating == 0 
			rating = 1
		end
		@consideration.add_vote(rating)
		session[:voted_upon] << @consideration.id
    	@consideration.reload
    	respond_to do |format|
    		format.html { redirect_to consideration_path(@consideration) }
    		format.js
    	end
	end
  	
  	def show
  		@consideration = Consideration.find(params[:id])
  		if signed_in?
  			@new_consideration = Consideration.new
  		end
  	end
  	
  	def search
  		@search_results = Consideration.search_tank(params[:query])
  	end
  	
#	removing search for heroku deployment  	
#  	def index
#  		@search = Consideration.search do
#    		fulltext params[:search]
#  		end
#  		@search_results = @search.results
#  	end
  	
  	def index
  		if Consideration.count != nil
  			@all_considerations = Consideration.paginate(:page => params[:page], :per_page => 30)
		end
  	end
end