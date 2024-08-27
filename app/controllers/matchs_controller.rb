class MatchsController < ApplicationController
  before_action :set_match, only: %i[show]
  def index
    @matches = policy_scope(Match)
  end

  def show
    authorize @match
    @message = Message.new
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end
end
