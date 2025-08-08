class User < ApplicationRecord
  ROLE_ADMIN = 1
  ROLE_MEMBER = 2
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_default_role, :set_default_username

  validates :user_name, presence: true, uniqueness: true, length: { minimum: 8 }
  validates :email, presence: true,
                      format: { with: URI::MailTo::EMAIL_REGEXP, message: "không đúng định dạng" },
                      uniqueness: { case_sensitive: false },
                      on: :create
  validates :password, presence: true,
                         length: { minimum: 6 },
                         format: { with: /\A(?=.*[A-Za-z])(?=.*\d).*\z/, message: "phải bao gồm chữ và số" },
                          if: :validate_password?
  def set_default_role
    self.role = ROLE_ADMIN if role.blank?
  end

  def set_default_username
    self.user_name = self.email if user_name.blank?
  end
  enum role: { user: 0, admin: 1 }
  scope :normal_users, -> { where(role: 0) }
  has_one_attached :avatar
  attr_accessor :remove_avatar
  private
  def validate_password?
      new_record? || password.present?
  end

end
