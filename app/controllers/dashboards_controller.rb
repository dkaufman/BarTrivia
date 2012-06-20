class DashboardsController < ApplicationController
  def show
    @past_games = Game.past_games
    @current_game = Game.current_game
    @new_game = Game.new unless @current_game
  end
end
