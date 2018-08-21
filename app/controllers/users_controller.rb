class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def show
    @user = User.find(params[:id])
    @favopics = Favorite.where(user_id: params[:id])
    @favorited_count = Favorite.where(favorited_user_id: params[:id]).count
  end
end
