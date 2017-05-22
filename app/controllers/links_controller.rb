class LinksController < ApplicationController
  def index
    unless current_user
      redirect_to authenticate_path
    end
  end
end
