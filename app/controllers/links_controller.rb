class LinksController < ApplicationController

  def index
    if current_user
      @link = Link.new
    else
      redirect_to '/login'
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      flash.now[:success] = "Link successfully updated"
      redirect_to root_path
    else
      flash[:failure] = @link.errors.messages.keys[0].to_s.capitalize + " #{@link.errors.messages.values[0][0].to_s}"
      redirect_to edit_link_path(@link)
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title)
  end
end
