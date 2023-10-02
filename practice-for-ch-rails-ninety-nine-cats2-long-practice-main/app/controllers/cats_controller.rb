class CatsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  # before_action only:[:edit, :update]
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
  
    @cat = Cat.new(cat_params)
    @cat.owner = current_user
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    user_id = current_user.id
    @cat = Cat.where(owner_id: user_id).find_by(id: params[:id])
    if @cat
      render :edit
    else
      redirect_to cats_url
    end
  end

  def update
    user_id = current_user.id
    @cat = Cat.where(owner_id: user_id).find_by(id: params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:birth_date, :color, :description, :name, :sex)
  end
end