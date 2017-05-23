class LinksController < ApplicationController

  def index
    if current_user
      @link = Link.new
    else
      redirect_to '/login'
    end
  end
end
