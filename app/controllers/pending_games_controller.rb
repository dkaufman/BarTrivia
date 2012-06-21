class PendingGamesController < ApplicationController
  def start
    game = Game.find(params[:id])
    game.start
    redirect_to dashboard_path
  end
end

