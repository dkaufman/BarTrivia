class GamesController < ApplicationController
  respond_to :json, :html

  def show
    @game = Game.find(params[:id])
  end

  def current_game
    respond_with(Game.current_game)
  end

  def create
    game = Game.new(params[:game])
    if game.save
      redirect_to game_path(game)
    else
      redirect_to dashboard_path
    end
  end
end
