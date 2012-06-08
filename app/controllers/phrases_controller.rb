class PhrasesController < ApplicationController
  respond_to :json

  def create
    respond_with Phrase.create!(params[:phrase])
  end

  def update
    phrase = Phrase.find(params[:id])
    phrase.update_attributes!(params[:phrase])
    respond_with phrase
  end
end