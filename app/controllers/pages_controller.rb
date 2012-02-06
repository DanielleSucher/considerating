class PagesController < ApplicationController
	def home
		@consideration = Consideration.random if Consideration.count != 0
  		@new_consideration = Consideration.new if signed_in?
  	end

  	def about
  	end
end