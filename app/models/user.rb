# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)      default(""), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :profile_attributes

  has_one :profile
  accepts_nested_attributes_for :profile

  delegate  :show_email,
            :birthday,
            :country,
            :gender,
            :about,
            :signature,
            :contacts_url,
            :contacts_other,
            :contacts_skype,
            :contacts_phone,
            :time_zone,
            :dispatch,
            :avatar,
            :to => :profile

  validates :name, presence: { message: "Имя пользователя должно быть заполненно!" }, uniqueness:{ case_sensitive: false, message:" - В нашей базе уже есть такое имя, придумайте пожалуйсто другое!" }, length:{maximum:50, too_long:" - Слишком длинное имя, Вам следует придумать что-нибудь покороче"}
  VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false, message: " - В нашей базе уже есть такой email, укажите пожалуйсто другое!" }, format:{with:VALID_EMAIL_FORMAT, message:" - Это поле должно иметь следующий формат: examle@mail.com"}
  validates :password, length: { minimum:8, too_short:" - Должен состоять не менее чем из 8 символов" }, on: :create, confirmation: true
  validates :password_confirmation, length: { minimum:8, too_short:" - Должен состоять не менее чем из 8 символов" }, on: :create
end