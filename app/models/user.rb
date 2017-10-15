class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #validates :username, presence: true, length: { minimum: 3, maximum: 22 }, uniqueness: true
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
  # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  # validates :password, presence: true, length: { minimum: 8 }, confirmation: true
  # validates :password_confirmation, presence: true

  validates :username, presence: true, uniqueness: true

  has_many :roleplays, dependent: :destroy
  has_many :characters, dependent: :destroy

  def to_s
    username
  end
end
