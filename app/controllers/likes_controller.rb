class LikesController < ApplicationController
  before_action :like_params, :set_liker, :set_liked, only: :create
  before_action :set_liked_ids, :set_followed_ids, :set_current_user_skills_preference, only: :index

  def index
    @users = policy_scope(User)
    @users = @users.where.not(id: set_liked_ids)
                   .where.not(id: set_followed_ids)
    @users = @users.includes(:wanted_skills, :proposed_skills)
                   .where(wanted_skills: { id: current_user.proposed_skills.pluck(:id) })
    @all = false
    @current_user_skills_preference = set_current_user_skills_preference
    if params.key?(:all)
      @all = true
    else
      @all = true if @users == []
      @users = @users.where(proposed_skills: { id: current_user.wanted_skills.pluck(:id) })
    end
  end

  def create
    @like = Like.new(like_params)
    @like.liker = set_liker
    @like.liked = set_liked
    authorize @like
    respond_to do |format|
      @like.save ? format.json { render status: 201 } : format.json { render json: @like.errors, status: 422 }
    end
  end

  private

  def like_params
    params.require(:like).permit(:wanted, :liker_id, :liked_id)
  end

  def set_liker
    User.find(params[:liker_id])
  end

  def set_liked
    User.find(params[:liked_id])
  end

  def set_liked_ids
    User.joins(:likes_as_liked).where(likes: { liker: current_user }).select(:id)
  end

  def set_followed_ids
    User.joins(:bookmarks_as_follower).where(bookmarks: { follower: current_user }).select(:id)
  end

  def set_current_user_skills_preference
    {
      wanted: current_user.wanted_skills.pluck(:name),
      proposed: current_user.proposed_skills.pluck(:name)
    }
  end
end
