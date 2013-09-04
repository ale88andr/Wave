module GeneralHelper
  # for Backend::EntityCategories
  def visibility param
    param ? 'Да' : 'Нет'
  end

  def is_parent param
    param === 0 ? 'Нет' : 'Да'
  end
end
