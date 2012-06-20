class GamesController < ApplicationController
  respond_to :json, :html

  def show
    @game = Game.find(params[:id])
  end

  def current_game
    respond_with(Game.current)
  end

  def create
    game = Game.new(params[:game])
    game.save
    redirect_to dashboard_path
  end

  def start
    game = Game.find(params[:id])
    game.start
    redirect_to dashboard_path
  end

  def finish
    game = Game.find(params[:id])
    game.finish
    redirect_to dashboard_path
  end
end
