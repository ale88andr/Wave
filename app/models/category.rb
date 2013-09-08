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

class Category < ActiveRecord::Base

  before_validation :category_parent

  attr_accessible :active, :description, :name, :parent_id, :eav_attribute_ids

  has_and_belongs_to_many :eav_attributes, class_name: "Attribute"

  validates :name, presence: { message: 'Это поле должно быть заполненно!' }, length: { maximum: 50, too_long: 'Слишком длинное название!' }, uniqueness: { message: 'Такое название уже существует!' }

  protected

    def category_parent
      if parent_id.nil?
        self.parent_id = 0
      end
    end

end