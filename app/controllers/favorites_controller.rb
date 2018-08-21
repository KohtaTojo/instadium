class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_data, only: [:create, :destroy]

  def index
    picture_ids = Favorite.group(:picture_id).order('count_picture_id').limit(20).count('picture_id').keys
    @pictures = picture_ids.map{|id| Picture.find(id)}
    user_ids = Favorite.group(:favorited_user_id).order('count_favorited_user_id').limit(10).count('favorited_user_id').keys
    @users = user_ids.map{|id| User.find(id)}
    puts @users
    @comment= Comment.new

  end

  def create
    @favorite = Favorite.create(user_id: current_user.id, picture_id: params[:picture_id], favorited_user_id: @picture.user.id)
    @favorites = Favorite.where(picture_id: params[:picture_id])
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, picture_id: params[:picture_id])
    @favorite.destroy
    @favorites = Favorite.where(picture_id: params[:picture_id], favorited_user_id: @picture.user.id)
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js
    end
  end

  private
  def set_data
    @picture = Picture.find(params[:picture_id])
    @like_buttons_1 = "#like-buttons-1-#{@picture.id}"
    @like_buttons_2 = "#like-buttons-2-#{@picture.id}"
    @favorite_count = "#favorite-count-#{@picture.id}"
  end
end
