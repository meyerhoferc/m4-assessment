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
    link = current_user.links.new(title: link_params[:title], url: link_params[:url])
    if link.save
      flash[:success] = 'Link successfully added'
      redirect_to root_path
    else
      flash[:danger] = 'Not successful'
      render :index
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
