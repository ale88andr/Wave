class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  validates :name, presence: { message: "Имя пользователя должно быть заполненно!" }, uniqueness:{ case_sensitive: false, message:" - В нашей базе уже есть такое имя, придумайте пожалуйсто другое!" }, length:{maximum:50, too_long:" - Слишком длинное имя, Вам следует придумать что-нибудь покороче"}
  VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false, message: " - В нашей базе уже есть такой email, укажите пожалуйсто другое!" }, format:{with:VALID_EMAIL_FORMAT, message:" - Это поле должно иметь следующий формат: examle@mail.com"}
  validates :password, length: { minimum:8, too_short:" - Должен состоять не менее чем из 8 символов" }, on: :create, confirmation: true
  validates :password_confirmation, length: { minimum:8, too_short:" - Должен состоять не менее чем из 8 символов" }, on: :create
end