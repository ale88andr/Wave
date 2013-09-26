class Manufacturers::IndexPresenter

  extend ActiveSupport::Memoizable

  def initialize category_id = nil
    @manufacturers_all = category_id.nil? ? Manufacturer.all : Manufacturer.category_manufacturers(category_id)
  end

  def quantity_products
    @manufacturers_all.size
  end

  def category_manufacturers
    @manufacturers_all.uniq
  end

  def category_name
    category_manufacturers.first.categories.first.name
  end

  memoize :category_manufacturers

end