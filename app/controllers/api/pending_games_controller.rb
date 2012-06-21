class PendingGamesController < ApplicationController
  respond_to :json

  def index
    respond_with(Game.pending)
  end
end

