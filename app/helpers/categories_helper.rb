module CategoriesHelper
	def getParentCategories
		Category.head
	end

	def pic ent
		image_tag ent.image.nil? ? "/img/entity/default.jpg" : ent.image.url
	end

	def exchange price
		'$ ' + (price / Currency.last.ratio).round(2).to_s
	end
end
