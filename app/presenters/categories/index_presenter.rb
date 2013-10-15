class Categories::IndexPresenter

  extend ActiveSupport::Memoizable

  def initialize params
    @category = Category.find_by_id(params[:id])
    @params = params
  end

  def current_category
    @category
  end

  def category_entities
    @category.entities.get_products_by_option(@params[:option]).page(@params[:page]).per(@params[:limit] ||= 5)
  end

  def category_entities?
    @category.entities.empty? ? false : true
  end

  alias_method :entities, :category_entities

  memoize :current_category, :category_entities

end