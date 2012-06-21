class Api::GamesController < ApplicationController
  respond_to :json

  def show
    respond_with(Game.current)
  end
end
