# == Schema Information
#
# Table name: units
#
#  id    :integer          not null, primary key
#  param :string(255)
#

class Unit < ActiveRecord::Base
  attr_accessible :param

  has_many :eav_attributes, class_name: "Attribute"

  validates :param, presence: { message: "Введите значение параметра!" }, length: { maximum: 50, too_lang: 'Слишком длинное значение!' }, uniqueness: { message: 'Такой параметр уже создан!' }

  default_scope order("param DESC")
end