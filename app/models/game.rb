class Game < ActiveRecord::Base
  attr_accessible :name
  has_many :questions

  validates :name, presence: true, length: { in: 5..100 }
  validate :only_one_active_game

  def self.past
    where(status: "finished")
  end

  def self.pending
    where(status: "pending")
  end

  def self.current
    Game.find_by_status("active")
  end

  def start
    self.status = "active"
    save
    Pusher['ls_trivia'].trigger('new_game', { :greeting => "Hello" })
  end

  def finish
    self.status = "finished"
    save
  end

  def question_count
    questions.count
  end

  # Validations

  def only_one_active_game
    return if self == Game.current

    if Game.find_by_status("active")
      errors[:base] << "There is already an active game"
    end
  end
end
