module Backend::EntitiesHelper
  def visible param
    param.blank? ? 'Нет' : "Да"
  end

  def getTechnologies
  	Technology.all
  end
end