class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture, only: [:edit, :update, :destroy, :show]

  def index
    @pictures = Picture.order(id: "DESC")
    @comment = Comment.new
    @users = User.all
  end

  def show
    @comment = Comment.new
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
      @picture.thumbnails.build
    end
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.thumbnails.present?
      if @picture.save
        CreateMailer.create_mail(@picture).deliver
        redirect_to pictures_path
      else
        render 'new'
      end
    else
      @picture.thumbnails.build
      render 'new'
    end
  end

  def edit
  end

  def update
    if current_user.id == @picture.user.id
      if @picture.update(picture_params)
        redirect_to root_path, confirm: "ツイートを編集しました"
      else
        render 'edit'
      end
    else
      redirect_to root_path, warning: "編集できません"
    end
  end

  def destroy
    if current_user.id == @picture.user.id
      @picture.destroy
      redirect_to root_path
    else
      redirect_to root_path, warning: "削除できません"
    end
  end

  private
  def picture_params
    params.require(:picture).permit(:content, thumbnails_attributes: [:image, :image_cache]).merge(user_id: current_user.id)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
