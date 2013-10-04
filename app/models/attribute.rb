# == Schema Information
#
# Table name: attributes
#
#  id      :integer          not null, primary key
#  name    :string(255)
#  unit_id :integer
#

class Attribute < ActiveRecord::Base
  attr_accessible :name, :unit_id

  has_and_belongs_to_many :categories
  has_many :parameters
  has_many :entities, through: :parameters

  belongs_to :unit

  validates :name, presence: { message: 'Это поле должно быть заполненно!' }, length: { maximum: 100, too_long: 'Слишком длинное название аттрибута!' }
end