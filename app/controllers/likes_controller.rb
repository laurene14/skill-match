class LikesController < ApplicationController
  before_action :like_params, only: :create
  before_action :set_liker, only: :create
  before_action :set_liked, only: :create

  def index
    @users = policy_scope(User)
    liked_users_ids = User.joins(:likes_as_liked).where(likes: { liker: current_user }).select(:id)
    followed_users_ids = User.joins(:bookmarks_as_follower).where(bookmarks: { follower: current_user }).select(:id)
    @users = @users.joins(:wanted_skills).where(skills: { id: current_user.proposed_skills.pluck(&:id) })
                   .where.not(id: liked_users_ids)
                   .where.not(id: followed_users_ids)
  end

  def create
    @like = Like.new(like_params)
    @like.liker = set_liker
    @like.liked = set_liked
    authorize @like
    respond_to do |format|
      @like.save ? format.json { render json: @like, status: 201 } : format.json { render json: @like.errors, status: 422 }
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
