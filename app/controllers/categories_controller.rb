class CategoriesController < ApplicationController
  def index
    @users = policy_scope(User)
    @categories = Category.all
  end
end
