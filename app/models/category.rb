# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  active      :boolean          default(TRUE)
#  parent_id   :integer          default(0), not null
#

class Category < ActiveRecord::Base

  before_validation :category_parent

  # самоприсоединение
  has_many :subcategories, class_name: "Category", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Category", foreign_key: "parent_id"

  attr_accessible :active, :description, :name, :parent_id, :eav_attribute_ids

  has_and_belongs_to_many :eav_attributes, class_name: "Attribute"

  has_many :entities
  has_many :manufacturers, through: :entities

  validates :name, presence: { message: 'Это поле должно быть заполненно!' }, length: { maximum: 50, too_long: 'Слишком длинное название!' }, uniqueness: { message: 'Такое название уже существует!' }

  scope :order_by_parent, order("parent_id ASC")
  scope :head, where("parent_id = ?", '0')

  protected

    def category_parent
      if parent_id.nil?
        self.parent_id = 0
      end
    end

end