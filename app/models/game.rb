class Game < ActiveRecord::Base
  attr_accessible :name
  has_many :questions

  validates :name, presence: true, length: { in: 5..100 }
  validate :only_one_active_game, on: :create

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
    unless self == Game.current
      errors[:base] << "There is already an active game" if Game.find_by_status("active")
    end
  end
end
