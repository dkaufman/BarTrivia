class PagesController < ApplicationController
  def home
    @game = Game.current
    @team = Team.new
  end
end
