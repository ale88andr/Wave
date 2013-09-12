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

  def get_attributes_by_category category_id
    #Attribute.find_by_
  end
end
