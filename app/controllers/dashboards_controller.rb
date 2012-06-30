class DashboardsController < ApplicationController
  layout 'dashboard'

  def show
    if @current_game = Game.current
      render "games/show"
    else
      @past_games = Game.past
      @pending_games = Game.pending.includes(:questions)
      @new_game = Game.new unless @current_game
    end
  end
end
