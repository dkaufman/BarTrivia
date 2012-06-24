class Api::QuestionsController < ApplicationController
  respond_to :json

  def show
    respond_with(Question.ask_next)
  end
end
