# == Schema Information
#
# Table name: entity_categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  active      :boolean          default(TRUE)
#  parent_id   :integer          default(0), not null
#

class EntityCategory < ActiveRecord::Base
  attr_accessible :active, :description, :name, :parent_id

  validates :name, presence: { message: 'Это поле должно быть заполненно!' }, length: { maximum: 50, too_long: 'Слишком длинное название!' }, uniqueness: { message: 'Такое название уже существует!' }
end