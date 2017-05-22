class LinksController < ApplicationController
  def index
    unless current_user
      redirect_to authenticate_path
    else
      @link = Link.new
      @links = current_user.links
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

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
