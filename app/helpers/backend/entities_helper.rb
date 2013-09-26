module Backend::EntitiesHelper
  def visible param
    param.blank? ? 'Нет' : "Да"
  end

  def getTechnologies
  	Technology.all
  end

  def trim text
    text.truncate(100, separator: '/', omission: '...') unless text.nil?
  end
end