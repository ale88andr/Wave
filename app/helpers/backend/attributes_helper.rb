module Backend::AttributesHelper
  def get_units
    Unit.all
  end

  def get_attributes
  	Attribute.all
  end
end
