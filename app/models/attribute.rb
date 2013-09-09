class Attribute < ActiveRecord::Base
  attr_accessible :name, :unit_id

  has_and_belongs_to_many :categories

  belongs_to :unit

  validates :name, presence: { message: 'Это поле должно быть заполненно!' }, length: { maximum: 100, too_long: 'Слишком длинное название аттрибута!' }

end