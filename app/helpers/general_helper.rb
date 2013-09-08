module GeneralHelper
  # for Backend::EntityCategories
  def visibility param
    param ? 'Да' : 'Нет'
  end

  def is_parent param
    param === 0 ? 'Нет' : "Да (#{Category.find_by_id(param).name})"
  end
end
