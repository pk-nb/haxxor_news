class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params) #TODO figure out parent type and combine
    if @vote.save?
      #return json?
    else
      #return json?
    end
  end

  def destroy

  end

  private
  def vote_params
    params.require(:vote).permit(:direction, :user_id, :parent_id, :parent_type)
  end
end
