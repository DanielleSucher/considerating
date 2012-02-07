class VotesController < ApplicationController
  before_filter :authenticate
  respond_to :html, :js

  def create
    @consideration = Consideration.find(params[:vote][:voted_id])
    current_user.vote!(@consideration, params[:vote][:rating])
    @consideration.reload
    respond_to do |format|
    	format.html { redirect_to consideration_path(@consideration) }
    	format.js
    end
  end
end