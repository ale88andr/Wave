module CategoriesHelper
	def getParentCategories
		Category.head
	end
end
