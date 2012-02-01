class PagesController < ApplicationController
	def home
		@consideration = Consideration.random if Consideration.count != 0
  		if signed_in?
  			@new_consideration = Consideration.new
  		end
  	end

  	def about
  	end
end
