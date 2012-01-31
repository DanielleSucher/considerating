class PagesController < ApplicationController
  def home
  	@consideration = Consideration.new if signed_in?
  end

  def about
  end
end
