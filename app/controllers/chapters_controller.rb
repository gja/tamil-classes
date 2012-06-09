class ChaptersController < ApplicationController
  respond_to :html

  def index
    respond_with @chapters = Chapter.all
  end

  def show
    respond_with @chapter = Chapter.find(params[:id])
  end

  def create
    respond_with @chapter = Chapter.create!(params[:chapter])
  end
end