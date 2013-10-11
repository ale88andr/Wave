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

  scope :products, includes(:entities).merge(Entity.chronology)
  scope :products_price_from, lambda { |cheap = true| includes(:entities).merge(Entity.price(cheap)) }
  scope :last_by, includes(:entities).merge(Entity.newest_by)
  scope :popular, includes(:entities).merge(Entity.popular)

  def Category.get_products_category_by_option option=nil, current_page=nil, per_page=5
    products = case option
      when 'newest'   then self.last_by(1.month.ago)
      when 'popular'  then self.popular
      when 'cheaper'  then self.products_price_from
      when 'hight'    then self.products_price_from(cheap = false)
      else self.products
    end
    products.page(current_page).per(per_page)
  end

  def facturers
    entities.select(:manufacturer_id).uniq
  end

  def total_entity_count
    subcategories.to_a.sum { |subcategory| subcategory.entities.count }
  end

  protected

    def category_parent
      if parent_id.nil?
        self.parent_id = 0
      end
    end

end