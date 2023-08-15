class Ability < ApplicationRecord
  belongs_to :character, optional: true
  before_save :update_passive

  scope :unused, -> { where(character_id: nil )}

  USES = [ "once", "twice", "thrice" ]

  QUALIFIERS = [
    "per fight",
    "per day",
    "per city",
    "per conversation",
    "per night",
    "per adventure",
    "per session",
    "per person",
  ]
    
  validates :qualifier, inclusion: { in: QUALIFIERS,
    message: "%{value} is not a valid qualifier", allow_blank: true }

  validates :uses, inclusion: { in: USES,
    message: "%{value} is not a valid qualifier", allow_blank: true }

  def use_amount
    return 1 if self.uses == "once"
    return 2 if self.uses == "twice"
    return 3 if self.uses == "thrice"
  end

  def is_passive?
    self.is_passive == true
  end

  def update_passive
    self.is_passive = true if (self.uses.blank? and self.qualifier.blank?)
  end

end
