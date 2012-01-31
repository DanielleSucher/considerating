class PagesController < ApplicationController
	def home
		if signed_in?
  			@consideration = Consideration.new
#  			@random_consideration = 
#  			@feed_items = current_user.feed
		else
#			@random_consideration = Consideration.find(:all, :order => 'random()')
			@random_consideration = Consideration.random
  		end
  	end

  	def about
  	end
end
