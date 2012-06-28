class Api::QuestionsController < ApplicationController
  respond_to :json

  def show
    respond_with(Question.ask_next)
  end

  def last
    respond_with(Question.last?)
  end

  def current
    respond_with(Question.current)
  end

  def times_up
    Question.times_up
    head :ok
  end

  def count
    respond_with(Question.number_remaining)
  end
end
