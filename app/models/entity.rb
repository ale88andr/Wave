# == Schema Information
#
# Table name: entities
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  price                   :float
#  price_in_currency       :float
#  bind_price              :boolean          default(FALSE), not null
#  currency_id             :integer
#  description             :text
#  discount_id             :integer
#  price_start_date        :date
#  price_end_date          :date
#  image                   :string(255)
#  published               :boolean          default(TRUE), not null
#  advise                  :string(255)
#  additional_shiping_cost :float
#  views                   :integer
#  rate                    :integer
#  characteristics         :text
#  manufacturer_id         :integer
#  category_id             :integer
#  availability            :integer
#  guarantee               :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null

class Entity < ActiveRecord::Base
  belongs_to :currency
  belongs_to :discount
  belongs_to :manufacturer
  belongs_to :category

  has_many  :attributes, through: :parameters
  has_many  :parameters, dependent: :destroy
  has_many  :discussions, dependent: :destroy
  has_many  :orders

  accepts_nested_attributes_for :parameters

  has_and_belongs_to_many :technologies

  attr_accessible :additional_shiping_cost, :advise, :availability, :bind_price, :characteristics, :description, :guarantee, :image, :name, :price, :price_end_date, :price_in_currency, :price_start_date, :published, :rate, :views, :category_id, :manufacturer_id, :parameters_attributes, :technology_ids

  before_save :set_characteristics_from_parameters_attributes, :set_currency
  before_destroy :ensure_not_referenced_by_any_order

  # technologies macros
  delegate  :description,
            :label,
            :name,
            to: :technologies,
            allow_nil: true,
            prefix: true

  # category macros
  delegate  :active,
            :description,
            :name,
            :parent_id,
            to: :category,
            allow_nil: true,
            prefix: true

  # manufacturer macros
  delegate  :description,
            :image,
            :name,
            :url,
            to: :manufacturer,
            allow_nil: true,
            prefix: true

  # currency macros
  delegate  :name,
            :abbreviation,
            :ratio,
            to: :currency,
            allow_nil: true,
            prefix: true

  validates :name, presence:{ message:'Это поле должно быть заполненно!' }, uniqueness:{ message:'Такое имя уже существует!' }
  validates :guarantee, allow_nil: true, numericality: { only_integer: " - Это поле должно содержать только цифровые значения" }
  validates :availability, allow_nil: true, numericality: { only_integer: " - Это поле должно содержать только целочисленные значения", greater_than: 0}
  validates :price, allow_nil: true, numericality: { message: " - Это поле должно содержать только цифровые значения", greater_than: 0}
  validates :price_in_currency, allow_nil: true, numericality: { message: " - Это поле должно содержать только цифровые значения", greater_than: 0}

  scope :chronology, lambda { |increase = nil| where(published: true).order("created_at #{increase ? 'ASC' : 'DESC'}") }
  scope :newest_by, lambda { |date = 1.week.ago| where("created_at >= ?", date).chronology }
  scope :by_rate, lambda { |top = true| chronology.order("rate #{top ? 'ASC' : 'DESC'}") }
  scope :unpublished, where("published: false")
  scope :price_range, lambda { |range_up = 0, range_to = 999999| where(price: range_up..range_to) }
  scope :price, lambda { |cheap| order("price #{cheap ? 'ASC' : 'DESC'}").chronology }
  scope :popular, chronology.order("views DESC")

  def set_characteristics_from_parameters_attributes
    self.characteristics = self.parameters.map { |e| e.value.to_s + e.attribute.unit.try(:param).to_s }.join(" / ")
  end

  def set_currency
    self.currency_id = self.bind_price ? Currency.first.id : Currency.last.id
  end

  private

    def ensure_not_referenced_by_any_order
      if orders.empty?
        return true
      else
        errors.add(:base, 'Существуют товарные позиции в заказах')
        return false
      end
    end

end