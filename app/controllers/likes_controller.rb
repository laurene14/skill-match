class LikesController < ApplicationController
  before_action :like_params, only: :create
  before_action :set_liker, only: :create
  before_action :set_liked, only: :create
  skip_before_action :verify_authenticity_token

  def index
    @users = policy_scope(User)
  end

  def create
    @like = Like.new(like_params)
    @like.liker = set_liker
    @like.liked = set_liked
    authorize @like
    respond_to do |format|
      @like.save ? format.json { render json: @like.to_json } : format.json { render json: @like.errors.to_json }
    end
  end

  private

  def like_params
    params.require(:like).permit(:wanted)
  end

  def set_liker
    User.find(params[:liker_id])
  end

  def set_liked
    User.find(params[:liked_id])
  end
end
