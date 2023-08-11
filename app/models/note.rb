class Note < ApplicationRecord
  belongs_to :user

  scope :visible, -> { where(private: false) }
  
end
