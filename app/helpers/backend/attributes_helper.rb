module Backend::AttributesHelper
  def get_units
    Unit.all
  end

  def get_attributes
  	Attribute.all
  end

  def get_categories
  	Category.order_by_parent
  end

  def get_manufacturers
  	Manufacturer.all
  end
end
