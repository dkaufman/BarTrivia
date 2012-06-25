class Question < ActiveRecord::Base
  attr_accessible :body, :solution, :category
  belongs_to :game
  has_many :responses

  validates :category, presence: true
  validates :body, presence: true
  validates :solution, presence: true

  def self.ask_next
    question = Game.current.questions.select{ |question| !question.already_asked? }.first
    question.mark_as_asked
    Waitress.announce_new_question
    return question
  end

  def self.last?
    Game.current.questions.select{ |question| !question.already_asked? }.empty?
  end

  def self.current
    Game.current.questions.select{ |question| question.already_asked? }.last
  end

  def self.times_up
    Waitress.announce_times_up
  end

  def already_asked?
    asked == true
  end

  def mark_as_asked
    self.asked = true
    save
  end
end
