class GamesController < ApplicationController
  respond_to :json, :html

  def show
    respond_with(Game.current)
  end

  def create
    game = Game.new(params[:game])

    if game.save
      redirect_to dashboard_path
    else
      @new_game = game
      @pending_games = []
      @past_games = []
      render :template => "dashboards/show"
    end
  end

  def finish
    game = Game.current
    game.finish
    redirect_to dashboard_path
  end
end
