class LinksController < ApplicationController
  def index
    unless current_user
      redirect_to authenticate_path
    else
      @link = Link.new
      @links = Link.where(user_id: current_user.id)
    end
  end

  def create
    if Link.is_valid?(link_params[:url]) && current_user.links.create(link_params)
      flash[:success] = 'Link successfully added'
      redirect_to root_path
    else
      @link = Link.new
      @links = current_user.links
      flash[:danger] = 'Invalid link'
      render :index
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if Link.is_valid?(link_params[:url]) && @link.update_attributes(link_params)
      flash[:success] = 'Link updated.'
      redirect_to root_path
    else
      flash[:danger] = 'Invalid link'
      render :edit
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :read)
  end
end
