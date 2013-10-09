class General::IndexPresenter

  extend ActiveSupport::Memoizable

  def initialize
    # @catalogue = Category.all
  end

  def parent_items
    Category.head
  end

  def last_discussions lim = 5
    Discussion.last(lim)
  end

  def recent_products date = 1.month.ago, lim = 5
    Entity.newest_by(date).limit(lim)
  end

  # memoize :category_manufacturers

end