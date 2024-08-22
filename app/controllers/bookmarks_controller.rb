class BookmarksController < ApplicationController
  before_action :set_follower, only: :create
  before_action :set_following, only: :create

  def create
    @bookmark = Bookmark.new
    @bookmark.follower = set_follower
    @bookmark.following = set_following
    authorize @bookmark
    respond_to do |format|
      @bookmark.save ? format.json { render json: @bookmark, status: 201 } : format.json { render json: @bookmark.errors, status: 422 }
    end
  end

  private

  def set_follower
    User.find(params[:follower_id])
  end

  def set_following
    User.find(params[:following_id])
  end

end
