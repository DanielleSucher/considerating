class VotesController < ApplicationController
  before_filter :authenticate
  respond_to :html, :js

  def create
    @consideration = Consideration.find(params[:vote][:voted_id])
    if params[:vote][:rating] != nil
	    current_user.vote!(@consideration, params[:vote][:rating])
	else
		current_user.vote!(@consideration, params[:rating])
	end
    @consideration.reload
    respond_to do |format|
    	format.html { redirect_to consideration_path(@consideration) }
    	format.js
    end
  end
end