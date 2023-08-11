class Character < ApplicationRecord

  has_many :abilities
  validates :name, presence: true

  validate :action_points_per_level
  validate :action_points_at_level_1, if: -> { self.level == 1 }
  validates :experience_points, numericality: { less_than_or_equal_to: 6 }
  validates :strength, numericality: { less_than_or_equal_to: 10 }
  validates :plot_armor, numericality: { less_than_or_equal_to: 7 }

  STATS = %w(will move fight sense seek)

  STATS.each do |method|
    define_method "#{method}_bonus" do
      bonus_for(self.send("#{method}"))
    end
  end

  def can_level_up?
    (self.stats.values.sum == Character.action_points_for_level(self.level)) && experience_points == 6
  end

  def self.action_points_for_level(level) =  10 + (level - 1) 

  def created_by = User.where(id: self.created_by_user_id).first

  def used_by = User.where(id: self.in_use_by_user_id).first

  def stats = self.slice STATS
  

  def bonus_for(action_points)
    case action_points
    when 0
      return "-1"
    when 1..2
      return "0"
    when 3..4
      return "+1"
    when 5..7
      return "+2"
    when 8
      return "+3"
    else
      return "Oops! You need to update your Action"
    end
  end

  def action_points_per_level
    current_action_points = [self.will, self.move, self.fight, self.sense, self.seek].sum
    
    required_action_points = (10 + (self.level - 1))

    unless current_action_points == required_action_points
      self.errors.add(:action_points, "sum total should be #{required_action_points} when creating a Level #{self.level} Character")
    end
  end



  def action_points_at_level_1
    unless [self.will, self.move, self.fight, self.sense, self.seek].all? { |action_points| action_points <= 4 }
      self.errors.add(:action_points, "when creating a new character, no Action may have more than 4 points")
    end
  end
end
