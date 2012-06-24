class Question < ActiveRecord::Base
  attr_accessible :body, :solution, :category
  belongs_to :game

  validates :category, presence: true
  validates :body, presence: true
  validates :solution, presence: true

  def self.ask_next
    question = Game.current.questions.select{ |question| !question.already_asked? }.first
    question.asked = true
    question.save
    return question
  end

  def already_asked?
    asked == true
  end

end
