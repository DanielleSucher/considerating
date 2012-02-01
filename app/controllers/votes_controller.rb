class VotesController < ApplicationController
  before_filter :authenticate

  def create
    @consideration = Consideration.find(params[:vote][:voted_id])
    current_user.vote!(@consideration, params[:vote][:rating])
    redirect_to root_path
  end
end