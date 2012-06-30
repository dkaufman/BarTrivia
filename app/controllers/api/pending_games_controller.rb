class Api::PendingGamesController < ApplicationController
  respond_to :json

  def show
    @game = Game.find(params[:id])
    render json: @game.to_json(include: :questions)
  end
end

