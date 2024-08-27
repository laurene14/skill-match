class LikesController < ApplicationController
  before_action :like_params, only: %i[create]
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
    liker_liked_id = [params[:liker_id], params[:liked_id]]
    @like.liker = User.find(liker_liked_id[0])
    authorize @like
    @like.liked = User.find(liker_liked_id[1])
    respond_to do |format|
      if @like.save
        Match.where(user1_id: liker_liked_id.min, user2_id: liker_liked_id.max).empty? ? format.json { render status: 201 } : format.json { render json: @like, status: 207 }
      else
        format.json { render json: @like.errors, status: 422 }
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    authorize @like
    respond_to do |format|
      @like.destroy ? format.json { render status: 201 } : format.json { render status: 422 }
    end
  end

  private

  def like_params
    params.require(:like).permit(:wanted, :liker_id, :liked_id, :id)
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
