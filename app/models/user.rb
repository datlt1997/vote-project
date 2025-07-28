class User < ApplicationRecord
  ROLE_ADMIN = 1
  ROLE_MEMBER = 2
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_default_role, :set_default_username

  validates :user_name, presence: true, uniqueness: true, length: { minimum: 8 }
  def set_default_role
    self.role = ROLE_ADMIN if role.blank?
  end

  def set_default_username
    self.user_name = self.email if user_name.blank?
  end
  enum role: { user: 0, admin: 1 }
  scope :normal_users, -> { where(role: 0) }
  has_one_attached :avatar
end
