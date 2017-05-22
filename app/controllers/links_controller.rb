class LinksController < ApplicationController

  def index
    if current_user
      @links = Link.all
    else
      redirect_to '/login'
    end
  end
end
