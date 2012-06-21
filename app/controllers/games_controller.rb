class GamesController < ApplicationController
  def create
    game = Game.new(params[:game])

    if game.save
      redirect_to dashboard_path
    else
      @past_games = Game.past
      @pending_games = Game.pending
      @new_game = game
      render :template => "dashboards/show"
    end
  end

  def finish
    game = Game.current
    game.finish
    redirect_to dashboard_path
  end
end
