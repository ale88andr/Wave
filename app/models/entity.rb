class Entity < ActiveRecord::Base
  belongs_to :currency
  belongs_to :discount
  belongs_to :manufacturer
  belongs_to :category

  has_many	:attributes, through: :parameters
  has_many	:parameters

  accepts_nested_attributes_for :parameters

  attr_accessible :additional_shiping_cost, :advise, :availability, :bind_price, :characteristics, :description, :guarantee, :image, :name, :price, :price_end_date, :price_in_currency, :price_start_date, :published, :rate, :views, :category_id, :manufacturer_id, :parameters_attributes

  before_save :set_characteristics_from_parameters_attributes

  validates :name, presence:{ message:'Это поле должно быть заполненно!' }, uniqueness:{ message:'Такое имя уже существует!' }
  validates :guarantee, allow_nil: true, numericality: { only_integer: " - Это поле должно содержать только цифровые значения" }
  validates :availability, allow_nil: true, numericality: { only_integer: " - Это поле должно содержать только целочисленные значения", greater_than: 0}
  validates :price, allow_nil: true, numericality: { message: " - Это поле должно содержать только цифровые значения", greater_than: 0}
  validates :price_in_currency, allow_nil: true, numericality: { message: " - Это поле должно содержать только цифровые значения", greater_than: 0}

  scope :last_by_date, order("created_at DESC")

  def set_characteristics_from_parameters_attributes
    self.characteristics = self.parameters.map { |e| e.value.to_s + e.attribute.unit.try(:param).to_s }.join(" / ")
  end

end