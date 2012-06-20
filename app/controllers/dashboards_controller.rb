class DashboardsController < ApplicationController
  def show
    @past_games = Game.past
    @pending_games = Game.pending
    @current_game = Game.current
    @new_game = Game.new unless @current_game
  end
end
