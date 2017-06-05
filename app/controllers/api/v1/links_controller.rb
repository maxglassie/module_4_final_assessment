class Api::V1::LinksController < ApplicationController

  def index
    @links = Link.all
    render json: @links
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      render json: @link, status: 201
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(read_link_params)
      render json: @link
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  private

  def link_params
    params.permit(:url, :title)
  end

  def read_link_params
    params.permit(:read)
  end
end
