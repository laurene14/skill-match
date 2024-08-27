class MatchsController < ApplicationController
  def index
    @matches = policy_scope(Match)
  end
end
