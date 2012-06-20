class PagesController < ApplicationController
  def home
    if game = Game.current_game
      redirect_to game_path(game)
    end
  end
end
