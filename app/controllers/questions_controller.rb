class QuestionsController < ApplicationController
  def new
    @game = Game.find(params[:pending_game_id])
    @question = Question.new
  end

  def create
    @game = Game.find(params[:pending_game_id])
    @question = @game.questions.new(params[:question])
    if @question.save
      redirect_to dashboard_path
    else
      render :new
    end
  end
end
