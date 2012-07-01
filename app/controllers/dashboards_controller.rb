class DashboardsController < ApplicationController
  before_filter :authenticate

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

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "dan" && password == "hungry"
    end
  end
end
