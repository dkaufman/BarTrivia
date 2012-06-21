class PendingGamesController < ApplicationController
  respond_to :json, :html

  def index
    respond_with(Game.pending)
  end

  def start
    game = Game.find(params[:id])
    game.start
    redirect_to dashboard_path
  end

end

