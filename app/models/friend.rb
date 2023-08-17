class Friend < ApplicationRecord
  using SignedStrings
  validates :bonus, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 2 }

  def availability
    return "Unknown" if available.blank? or available.nil?
    available ? "Available!" : "Unavailable" 
  end

  def bonus
    super.to_ss
  end
end
