module Backend::EntitiesHelper
  def visible param
    param.blank? ? 'Нет' : "Да"
  end
end