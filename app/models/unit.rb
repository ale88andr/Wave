class Unit < ActiveRecord::Base
  attr_accessible :param

  has_many :attributes

  validates :param, presence: { message: "Введите значение параметра!" }, length: { maximum: 50, too_lang: 'Слишком длинное значение!' }, uniqueness: { message: 'Такой параметр уже создан!' }

  default_scope order("param DESC")
end
