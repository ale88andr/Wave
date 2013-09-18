class Technology < ActiveRecord::Base
  attr_accessible :description, :label, :name
  has_and_belongs_to_many :entities

  mount_uploader :label, LabelUploader

  validates :name, presence: { message: 'Это поле должно быть заполненно!' }, length: { maximum: 100, too_long: 'Слишком длинное название!' }
end
