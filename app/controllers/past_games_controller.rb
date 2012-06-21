class PastGamesController < ApplicationController
  respond_to :json, :html

  def index
    respond_with(Game.past)
  end

end


