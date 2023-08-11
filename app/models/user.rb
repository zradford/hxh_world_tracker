class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :characters, foreign_key: :in_use_by_user_id


  enum role: {player: 0, admin: 1}

  def assign_default_role
    self.role ||= :player
  end

  def username
    self.email[0...email.index('@')]
  end
end
